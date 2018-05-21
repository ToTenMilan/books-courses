class CompositeBase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.member_of(composite_name)
    code = %Q{
      attr_accessor :parent_#{composite_name}
    }
    class_eval(code)
  end

  def self.composite_of(composite_name)
    member_of composite_name

    code = %Q{
      def sub_#{composite_name}s
        @sub_#{composite_name}s = [] unless @sub_#{composite_name}s
        @sub_#{composite_name}s
      end

      def add_sub_#{composite_name}(child)
        return if sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s << child
        child.parent_#{composite_name} = self
      end

      def delete_sub_#{composite_name}(child)
        return unless sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s.delete(child)
        child.parent_#{composite_name} = nil
      end
    }
    class_eval(code)
  end
end

class Tiger < CompositeBase
  member_of(:population)
  member_of(:classification)
  composite_of(:specie)
  # Lots of code omitted . . .
end

class Tree < CompositeBase
  member_of(:population)
  member_of(:classification)
  # Lots of code omitted . . .
end

def member_of_composite?(object, composite_name)
  object.respond_to?("parent_#{composite_name}")
end

t = Tiger.new('tony')
p t.name
t.parent_population = 'cats'
p t.parent_population

t.parent_specie = 'African Animals'
p t.parent_specie
p t.public_methods

p member_of_composite?(t, 'specie')

t.add_sub_specie('white_tigers')
t.add_sub_specie('bengal_tigers')


# p t.sub_species
# t.delete_sub_specie('bengal_tigers')
# p t.sub_species