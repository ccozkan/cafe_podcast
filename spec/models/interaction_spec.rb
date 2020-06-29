require 'rails_helper'

RSpec.describe Interaction, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to belong_to(:episode) }
      it { is_expected.to belong_to(:user) }
    end
  end
end
