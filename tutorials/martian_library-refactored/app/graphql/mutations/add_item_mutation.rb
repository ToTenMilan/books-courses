module Mutations
  class AddItemMutation < Mutations::BaseMutation
    argument :attributes, Types::ItemAttributes, required: true

    field :item, Types::ItemType, null: true
    field :errors, Types::ValidationErrorsType, null: false

    def resolve(attributes:)
      check_authentication!

      item = Item.new(attributes.to_h.merge(user: context[:current_user]))

      if item.save
        # 1. camelCased field name 2. options 3. root object of subscrilption update
        MartianLibrarySchema.subscriptions.trigger('itemAdded', {}, item) # itemAdded is a field defined in Types::SubscriptionType
        { item: item }
      else
        { errors: item.errors }
      end
    end
  end
end