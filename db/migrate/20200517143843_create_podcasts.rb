class CreatePodcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :podcasts do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :media_url
      t.date :last_publish_date
      t.integer :number_of_episodes
      t.integer :added_by
      t.text :categories, array: true, default: []

      t.timestamps
    end
  end
end
