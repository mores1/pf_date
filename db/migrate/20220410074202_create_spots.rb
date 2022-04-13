class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
