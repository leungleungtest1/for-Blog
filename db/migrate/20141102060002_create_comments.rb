class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.timestamps
      t.integer :user_id, :post_id
    end
  end
end
