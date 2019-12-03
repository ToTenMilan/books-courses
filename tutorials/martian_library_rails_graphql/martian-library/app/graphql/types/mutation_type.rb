module Types
  class MutationType < Types::BaseObject
    field :update_item, mutation: Mutations::UpdateItemMutation
    field :add_item, mutation: Mutations::AddItemMutation
    field :sign_in, mutation: Mutations::SignInMutation
  end
end
