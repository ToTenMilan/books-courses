module Types
  class UserType < Types::BaseObject
    # columns
    field :id, ID, null: false
    field :email, String, null: false
    field :full_name, String, null: false

    # method 'on the fly' (just like in serializer from activemodel_serializers)
    def full_name
      # `object` references the user instance
      [object.first_name, object.last_name].compact.join(" ")
    end
  end
end
