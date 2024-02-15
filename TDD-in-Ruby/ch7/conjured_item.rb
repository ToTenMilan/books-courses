require_relative 'regular_item'

class ConjuredItem < RegularItem
  def update
    decrease_quality
    if expired?
      decrease_quality
    end
  end

  # Can't delete because they are used in the subclasses
  def decrease_quality
    if @item.quality > 0
      @item.quality -= 1
    end
  end
end
