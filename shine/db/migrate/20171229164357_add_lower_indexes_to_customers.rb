class AddLowerIndexesToCustomers < ActiveRecord::Migration[5.1]
  def change
    # varchar_pattern_ops - feature of postgres called OPERATOR CLASSES.
    # this is the non standard(non default operaor) need to be used because of using LIKE
    add_index :customers, "lower(last_name) varchar_pattern_ops"
    add_index :customers, "lower(first_name) varchar_pattern_ops"
    add_index :customers, "lower(email)"
  end
end
