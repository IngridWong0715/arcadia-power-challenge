require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'Association test' do
    it { should belong_to(:user)}
    it { should have_many(:bills) }
  end

  describe 'Validation test' do
    it { should validate_presence_of(:utility) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:account_number) }
    it { should validate_inclusion_of(:category).in_array(['commercial', 'residential']) }
  end
end
