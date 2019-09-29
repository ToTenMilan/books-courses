#*******************************************************************************
# Przygotowanie, str. 43
#*******************************************************************************
require 'fiddle'
SIZEOF_HEAP_PAGE_HEADER_STRUCT = Fiddle::SIZEOF_VOIDP
SIZEOF_RVALUE           = 40
HEAP_PAGE_ALIGN_LOG     = 14
HEAP_PAGE_ALIGN         = 1 << HEAP_PAGE_ALIGN_LOG      # 2 ^ 14
HEAP_PAGE_ALIGN_MASK    = ~(~0 << HEAP_PAGE_ALIGN_LOG)  # Maska do uzyskania adresu strony
REQUIRED_SIZE_BY_MALLOC = Fiddle::SIZEOF_SIZE_T * 5     # padding na potrzeby malloc
HEAP_PAGE_SIZE          = HEAP_PAGE_ALIGN - REQUIRED_SIZE_BY_MALLOC # Rozmiar strony
HEAP_PAGE_OBJ_LIMIT     = (HEAP_PAGE_SIZE - SIZEOF_HEAP_PAGE_HEADER_STRUCT) / SIZEOF_RVALUE
#*******************************************************************************
# Numer strony, str. 44
#*******************************************************************************
def page_address_from_object_address object_address
  object_address & ~HEAP_PAGE_ALIGN_MASK
end
#*******************************************************************************
# Informacje o stronie, str. 44
#*******************************************************************************
Page = Struct.new :address, :obj_start_address, :obj_count
def page_info page_address
  limit = HEAP_PAGE_OBJ_LIMIT # Maksymalna ilość obiektów na stronie
  # Strony posiadają nagłówek
  obj_start_address = page_address + SIZEOF_HEAP_PAGE_HEADER_STRUCT
  # Jeśli obiekt rozpoczyna się pod adresem dzielącym się przez
  # rozmiar obiektu Ruby z resztą, wówczas należy obliczyć 
  # również padding podzielny przez SIZEOF_RVALUE
  if obj_start_address % SIZEOF_RVALUE != 0
    delta = SIZEOF_RVALUE - (obj_start_address % SIZEOF_RVALUE)
    obj_start_address += delta
    # Liczba obiektów możliwa do składowania w danej stronie
    limit = (HEAP_PAGE_SIZE - (obj_start_address - page_address)) / SIZEOF_RVALUE
  end
  Page.new page_address, obj_start_address, limit
end # page_info
#*******************************************************************************
# Zrzut pamięci, str. 44
#*******************************************************************************
require 'objspace'
x = 100_000.times.map { Object.new }
GC.start
File.open('heap.json', 'w') { |f|
  ObjectSpace.dump_all(output: f)
}
#*******************************************************************************
# Struktura strony, str. 45
#*******************************************************************************
require 'json'
class Page
  def initialize address, obj_start_address, obj_count
    super
    @live_objects = []
  end # initialize
  def add_object address
    @live_objects << address
  end # add_object
end # Page
pages = {}
File.open('heap.json') do |f|
  f.each_line do |line|
    object = JSON.load line
    # Pomijamy główny węzeł
    if object["type"] != "ROOT"
      # Adres obiektów w zapisie 'base 16'
      address      = object["address"].to_i(16)
      # Adres strony
      page_address = page_address_from_object_address(address)
      # Pobierz stronę
      page         = pages[page_address] ||= page_info(page_address)
      page.add_object address
    end
  end # f.each_line
end # File.open
#*******************************************************************************
# Rozszerzenie struktura strony, str. 45
#*******************************************************************************
class Page
  def each_slot
    return enum_for(:each_slot) unless block_given?
    objs = @live_objects.sort
    obj_count.times do |i|
      expected = obj_start_address + (i * SIZEOF_RVALUE)
      if objs.any? && objs.first == expected
        objs.shift
        yield :full
      else
        yield :empty
      end
    end # obj_count.times
  end # each_slot
end # Page
#*******************************************************************************
# Generowanie wizualizacji (str. 46)
#*******************************************************************************
require 'chunky_png'
pages = pages.values
# Wizualna reprezentacja obiektów to piksele o rozmiarze 2x2
# zatem rozmiarem PNG, będzie 2x maksymalna ilości obiektów dla wysokości
# oraz 2x ilość stron
height = HEAP_PAGE_OBJ_LIMIT * 2
width = pages.size * 2
puts "H:#{height}, W:#{width}"
png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
# Wszystkie strony
pages.each_with_index do |page, i|
  i = i * 2
  page.each_slot.with_index do |slot, j|
    if slot == :full
      j = j * 2
      png[i, j] = ChunkyPNG::Color.rgba(255, 0, 0, 255)
      png[i + 1, j] = ChunkyPNG::Color.rgba(255, 0, 0, 255)
      png[i, j + 1] = ChunkyPNG::Color.rgba(255, 0, 0, 255)
      png[i + 1, j + 1] = ChunkyPNG::Color.rgba(255, 0, 0, 255)
    end
  end # page.each_slot
end # pages.each_with_index
png.save('heap.png', :interlace => true)