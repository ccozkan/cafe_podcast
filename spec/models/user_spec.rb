require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to have_many(:subscriptions) }
      it { is_expected.to have_many(:contents).through(:subscriptions) }
    end
  end
end
