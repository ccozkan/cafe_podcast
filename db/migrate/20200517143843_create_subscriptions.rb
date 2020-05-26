class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :media_url
      t.date :last_publish_date
      t.integer :number_of_episodes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
