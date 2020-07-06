require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  context '' do
    let(:user) { FactoryBot.create(:user)  }

    before do
      # faking login
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    it "index method" do
      get :index
      expect(response).to have_http_status(:success)
    end

    let(:sub_params) do { url: 'https://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss' } end
    let(:sub_params_wrong) do { url: 'https://wrongurl.test' } end

    it "create method" do
      get :create, params: sub_params
      expect(Podcast.find_by(url: sub_params[:url])).not_to eq nil
      expect(response).to redirect_to(subscriptions_path)
    end

    it "create method" do
      get :create, params: sub_params
      expect(Podcast.find_by(url: sub_params_wrong[:url])).to eq nil
      # TODO: add error chechk test
      # expect(response).not_to redirect_to(subscriptions_path)
    end

    # describe 'user_subscribed method' do let!(:subbed_podcast) { FactoryBot.create(:podcast) }
    #   let!(:not_subbed_podcast) { FactoryBot.create(:podcast) }

    #   # TODO: private method check
    #   it '' do
    #     # get :index
    #   end
    # end
  end
end
