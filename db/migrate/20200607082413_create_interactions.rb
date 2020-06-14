class CreateInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :interactions do |t|
      t.references :episode
      t.references :user

      t.boolean :starred
      t.boolean :listened

      t.timestamps
    end
  end
end
