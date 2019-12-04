module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def check_authentication!
      return if context[:current_user]
      raise GraphQL::ExecutionError, 'You need to log in'
    end
  end
end