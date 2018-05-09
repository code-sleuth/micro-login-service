# spec/features/creating_farm_spec.rb
require "rails_helper"
require "./spec/helpers/users_spec_helper"

RSpec.describe "creating a farm", type: :feature do
  include UsersSpecHelper
  it "successfully creates farm" do
    visit "/invites"
    expect(page).to have_content "Expired or Broken Link"
    click_button "Request New Link"
    expect(page).to have_content "Sorry record not found"
  end
end
