require 'rails_helper'

RSpec.describe Bill, type: :model do

  describe 'Association test' do
    it { should belong_to(:account) }
  end

  describe 'Validations test' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:usage) }
    it { should validate_presence_of(:charges) }
    it { should validate_presence_of(:status) }

    it { should validate_numericality_of(:usage) }
    it { should validate_numericality_of(:charges) }

    it { should validate_inclusion_of(:status).in_array(['paid', 'unpaid']) }
  end


end
