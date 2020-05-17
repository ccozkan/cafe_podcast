class AddKeywordsToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :keywords, :text, array: true, default: []
  end
end
