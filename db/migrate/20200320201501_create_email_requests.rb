class CreateEmailRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :email_requests do |t|
      t.string :to, null: false
      t.string :to_name, null: false
      t.string :from, null: false
      t.string :from_name, null: false
      t.string :subject, null: false
      t.string :body, null: false
    end
  end
end
