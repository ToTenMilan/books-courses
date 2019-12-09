module Mutations
  class UpdateItemMutation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :attributes, Types::ItemAttributes, required: true

    field :item, Types::ItemType, null: true
    field :errors, [String], null: false

    def resolve(id:, attributes:)
      check_authentication!

      item = Item.find(id)

      if item.update(attributes.to_h)
        MartianLibrarySchema.subscriptions.trigger("itemUpdated", {}, item)
        { item: item }
      else
        { errors: item.errors.full_messages }
      end
    end
  end
end