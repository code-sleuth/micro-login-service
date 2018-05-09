require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is not valid without a name" do
    role = Role.new(name: nil)
    expect(role).to_not be_valid
  end

  it "expects name to be present" do
    role = Role.new
    expect(role).to_not be_valid
  end

  it "should have a unique name" do
    Role.create!(name:"Foo")
    foo = Role.new(name:"Foo")
    foo.should_not be_valid
  end
end