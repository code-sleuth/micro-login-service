require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one :assignment }
  it { is_expected.to have_one(:role).through(:assignment) }
end
