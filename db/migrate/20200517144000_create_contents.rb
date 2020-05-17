class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :url
      t.string :title
      t.text :summary
      t.date :publish_date
      t.integer :duration
      t.boolean :listened
      t.boolean :starred
      t.string :entry_id
      t.references :subscription, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
