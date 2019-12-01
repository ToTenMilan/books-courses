class MartianLibrarySchema < GraphQL::Schema
  mutation(Types::MutationType) # send all mutations to Types::QueryType
  query(Types::QueryType) # send all queris to Types::QueryType
end
