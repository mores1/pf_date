class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :star
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
