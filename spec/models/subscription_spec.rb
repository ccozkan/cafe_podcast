require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:contents) }
      it { is_expected.to validate_presence_of(:url) }
    end
  end
end
