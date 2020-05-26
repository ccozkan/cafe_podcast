ActiveAdmin.register Subscription do

  actions :all, except: [:destroy, :new, :create]

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :url
    column :last_publish_date
    column :number_of_episodes
    column :categories
    column :user_id
    column :created_at
    column :updated_at
    column :media_url
    actions
  end
end
