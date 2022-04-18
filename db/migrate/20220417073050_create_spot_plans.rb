class CreateSpotPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_plans do |t|
      t.integer :spot_id
      t.integer :plan_id
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
