require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  it "emails user when requesting password reset" do
    user = create(:user)
    visit login_path
    click_link "password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.to.should include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "password"
    fill_in "Email", :with => "nobody@example.com"
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.should be_nil
  end
end
