##### Antipattern
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = Toy.where(pet_id: @pet.id, cute: true)
  end
end


##### solution 1
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.toys.cute
  end
end

class Pet < ActiveRecord::Base
  has_many :toys
end

class Toy < ActiveRecord::Base
  scope :cute, where(cute: true) # ~rails 3
  scope :cute, -> { where(cute: true) } # ~rails 4
end



##### solution 2 - when `Toy` belong to many models
module ToyAssociationMethods
  def cute
    where(cute: true)
  end
end

class Pet < ActiveRecord::Base
  has_many :toys, extend: ToyAssociationMethods
end

class Owner < ActiveRecord::Base
  has_many :toys, extend: ToyAssociationMethods
end



##### solution 3
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.toys.appropriate
  end
end

class Toy < ActiveRecord::Base
  # has column :minimum_age
end


class Pet < ActiveRecord::Base
  # has column :age
  has_many :toys do
    def appropriate
      where(["minimum_age < ?", proxy_owner.age]) # proxy_owner will become the one that implements this has_many, in this case `Pet` instance
    end
  end
end
