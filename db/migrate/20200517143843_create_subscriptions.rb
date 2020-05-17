class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :url
      t.string :media_url
      t.datetime :last_publish
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
