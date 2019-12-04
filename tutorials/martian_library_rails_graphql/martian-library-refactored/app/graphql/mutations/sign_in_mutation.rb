module Mutations
  class SignInMutation < Mutations::BaseMutation
    # accepted params
    argument :email, String, required: true

    # what is returned
    field :token, String, null: true
    field :user, Types::UserType, null: true

    # resolve is boilerplate
    def resolve(email:)
      user = User.find_by!(email: email)
      return {} unless user

      token = Base64.encode64(user.email)
      {
        token: token,
        user: user
      }
    rescue ActiveRecord::RecordNotFound
      raise GraphQl::ExecutionError, 'user not found'
    end
  end
end