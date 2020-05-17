class AddCategoriesToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :categories, :text, array: true, default: []
  end
end
