class CreateInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :interactions do |t|
      t.references :episode
      t.references :user

      t.boolean :is_starred, default: false
      t.boolean :is_listened, default: false

      t.timestamps
    end
  end
end
