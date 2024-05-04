require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it {is_expected .to have_many(:posts)}
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_most(14) }
    it { is_expected.to allow_value('luis').for(:username) }
    it { is_expected.not_to allow_value('luis@').for(:username) }
  end
end
