# Always provide a `down` method.
# If it is not possible to migrate down, raise an exception:
def down
  raise ActiveRecord::IrreversibleMigration
end
