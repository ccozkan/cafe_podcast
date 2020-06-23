require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to have_many(:subscriptions) }
      it { is_expected.to have_many(:podcasts).through(:subscriptions) }
      it { is_expected.to have_many(:interactions) }
      it { is_expected.to have_many(:episodes).through(:interactions) }
    end
  end
end
