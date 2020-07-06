class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :podcast
      t.references :user

      t.boolean :is_favorite, default: false

      t.timestamps
    end
    add_index :subscriptions, [:podcast_id, :user_id], unique: true
  end
end
