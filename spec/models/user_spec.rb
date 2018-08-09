require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association test' do
    it { should have_many(:accounts) }
    it { should have_many(:bills) }
  end

  describe 'Validations test' do
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(['active', 'inactive']) }
  end
end
