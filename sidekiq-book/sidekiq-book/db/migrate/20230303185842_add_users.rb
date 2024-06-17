class AddUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, comment: "Users of the system" do |t|
      t.citext :email, null: false, index: { unique: true },
        comment: "Email address of this user"
      t.text :payments_customer_id, null: false, index: { unique: true },
        comment: "ID of the customer in our payments service"
      t.text :payments_payment_method_id, null: false, index: { unique: true },
        comment: "ID of the customer's chosen payment method in our payments service"

      t.timestamps null: false
    end
    add_reference :orders, :user, null: false, foreign_key: true,
      comment: "Which user placed and paid-for this order?"

    add_column :orders, :charge_completed_at, :datetime, null: true,
      comment: "If set, when was the charge completed?"
    add_column :orders, :charge_successful, :boolean, null: false, default: false,
      comment: "If the charge was completed, was it successful or was it declined?"
    add_column :orders, :charge_decline_reason, :text, null: true,
      comment: "If the charge was declined, why?"
    add_column :orders, :charge_id, :text, null: true,
      comment: "If this was paid for, what was the charge id from the remote system?"

    add_column :orders, :email_id, :text, null: true,
      comment: "If the email confirmation went out, what was the id in the remote system?"

    add_column :orders, :fulfillment_request_id, :text, null: true,
      comment: "If the order's fulfillment was requested,, what was the id in the remote system?"
  end
end
