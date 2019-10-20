#*******************************************************************************
# Biblioteki
#*******************************************************************************
require 'rubygems'
require 'json'
require 'active_record'
require 'active_support/core_ext'

#*******************************************************************************
# Parametryzacja
#*******************************************************************************
puts ARGV.inspect
PARAM_DB_NAME  = ARGV[0]
PARAM_AR_CLASS = ARGV[1]
PARAM_AR_TABLE = ARGV[2]

#*******************************************************************************
# Dynamiczne mapowanie klas ActiveRecord
# Tabela źródłowa i tabela synchronizacyjna
#*******************************************************************************
eval <<-DYNAMIC
  class #{PARAM_AR_CLASS} < ActiveRecord::Base
    self.table_name = "#{PARAM_AR_TABLE}"
    self.inheritance_column = :_type_disabled
  end
  class Sync#{PARAM_AR_CLASS} < ActiveRecord::Base
    self.table_name = "sync_#{PARAM_AR_TABLE}"
  end
DYNAMIC

#*******************************************************************************
# Połączenie 
#*******************************************************************************
conn = ActiveRecord::Base.establish_connection(:adapter=>"postgresql",
                                               :encoding=>"unicode", 
                                               :pool=>1,
                                               :database=>"#{PARAM_DB_NAME}",
                                               :username=>"#{PARAM_DB_NAME}",
                                               :password=>"hasło",
                                               :host=>"172.28.128.11")
# Brak połączenia
if conn.nil? then raise '!: NO -AR- CONNECTION' end

#*******************************************************************************
# Przetwarzanie
#*******************************************************************************
Time::DATE_FORMATS[:no_timezone] = "%Y-%m-%d %H:%M:%S"
# Dynamiczne mapowanie i przetwarzanie rekordów grupami
PARAM_AR_CLASS
.classify
.constantize
.joins("left join sync_#{PARAM_AR_TABLE} 
        ON #{PARAM_AR_TABLE}.id = sync_#{PARAM_AR_TABLE}.id")
.where("sync_#{PARAM_AR_TABLE}.id is null")
.find_in_batches(batch_size:100_000) { |group|
  # classify i constantize
  params_list = "#{PARAM_AR_CLASS}".classify
                                   .constantize
                                   .new
                                   .attributes
                                   .map { |x| '[' + x[0] + ']' }.join(", ")
  # Bazowe zapytanie SQL
  base = "INSERT INTO #{PARAM_AR_TABLE} ( #{params_list} ) VALUES " 
  sql_insert = base
  # Wszystkie elementy w grupie
  group.each_with_index do |p,index|
    arr = []
    # Atrybuty
    p.attributes.each do |a|
      puts "#{a[0]} => #{a[1].class}"
      # Przetwarzanie atrubutów tabeli
      if a[1].class == NilClass then
        arr << "NULL"
      elsif a[1].class == String then
        tmp = a[1].gsub("'", "''")
        arr << "'" + tmp + "'"
      elsif a[1].class == Time then
        arr << "'" + a[1].to_s(:no_timezone) + "'"
      elsif a[1].class == TrueClass || a[1].class == FalseClass then
        tmp = 5 - a[1].to_s.length
        arr << tmp
      else
        arr << a[1]
      end # if
    end # p.attributes.each
    puts arr.inspect
    # Uzupełnianie 
    sql_insert = sql_insert +  "(" + arr.join(",") + ")"
    # Tutaj możemy np. wykonać grupowanie zapytań po 1000
    puts "#{$$} -> #{index} -> #{sql_insert}"
    if index % 100 == 0 then puts "#{index}" end
    sql_insert = base
    # classify i constantize
    s = "Sync#{PARAM_AR_CLASS}".classify.constantize.new
    s.id = p.id
    # Zapis do tabeli synchronizacyjnej
    s.save!
  end # group.each_with_index
} # find_in_batches