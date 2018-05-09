require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :assignments }
  it { is_expected.to have_many(:roles).through(:assignments) }

  describe "user initialization" do
    it "is not valid without a role" do
    user = User.new(email: 'something@gmail.com',
        password:'stuff@stuff', password_confirmation: 'stuff@stuff')
      expect(user).to_not be_valid
    end

    it "is valid with a role" do
      role = create(:role, name: "admin")
      user = User.new(email: 'something@gmail.com', roles: [role],
        password:'stuff@stuff', password_confirmation: 'stuff@stuff')
      expect(user).to be_valid
    end

    it "can compare role" do
      role = create(:role, name: "admin")
      user = User.new(email: 'something@gmail.com', roles: [role],
        password:'stuff@stuff', password_confirmation: 'stuff@stuff')

      expect(user.role? :admin).to be true
    end
    it "should not create without an email" do
      role = create(:role, name: "admin")
      user = User.new(roles: [role],
        password:'stuff@stuff', password_confirmation: 'stuff@stuff')

      expect(user).to_not be_valid
    end
  end
end
