class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :url
      t.string :title
      t.text :summary
      t.date :publish_date
      t.integer :duration
      t.string :entry_id
      t.text :keywords, array: true, default: []
      t.references :podcast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
