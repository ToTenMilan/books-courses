module Mutations
  class AddItemMutation < Mutations::BaseMutation
    field :item, Types::ItemType, null: true
    field :errors, [String], null: false

    argument :title, String, required: true
    argument :description, String, required: false
    argument :image_url, String, required: false

    def resolve(title:, description: nil, image_url: nil)
      if context[:current_user].nil?
        raise GraphQL::ExecutionError, "You need to Log in"
      end
      item = Item.new(
        title: title,
        description: description,
        image_url: image_url,
        user: context[:current_user]
      )
      if item.save
        { item: item }
      else
        { errors: item.errors.full_messages }
      end
    end
  end
end
