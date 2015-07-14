### UTILITY METHODS ###

def create_admin
  @admin ||= { :username => "admin", :name => "admin", :email => "33225762@qq.com", :password => "admin"}
  # binding.pry
end

def find_admin
  @admin ||= User.where(:email => @admin[:email]).first
end


def delete_user
  @admin ||= User.where(:email => @admin[:email]).first
  @admin.destroy unless @admin.nil?
end

def sign_up
  delete_user
  visit '/signup'
  fill_in "user_name", :with => @admin[:name]
  fill_in "user_email", :with => @admin[:email]
  fill_in "user_username", :with => @admin[:username]
  fill_in "user_password", :with => @admin[:password]
  click_button "创建帐号"
  find_user
end

def sign_in
  visit '/login'
  fill_in "login", :with => @admin[:username]
  fill_in "password", :with => @admin[:password]
  click_button "登录"
end

### GIVEN ###
Given /^I am not logged in$/ do
  delete '/logout'
end

Given /^I am logged in$/ do
  create_admin
  sign_in
end

Given /^I exist as a admin/ do
  create_admin
end

Given /^I do not exist as a admin/ do
  create_admin
  delete_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  sign_in
end

When /^I sign out$/ do
  delete '/logout'
end

When /^I sign up with valid user data$/ do
  create_admin
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_admin
  @admin = @admin.merge(:email => "notanemail")
  sign_up
end


When /^I sign up without a password$/ do
  create_admin
  @admin = @admin.merge(:password => "")
  sign_up
end


When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong username/ do
  @admin = @admin.merge(:username => "wrongname")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @admin = @admin.merge(:password => "wrongpass")
  sign_in
end


When /^I look at the list of topics$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "退出"
  page.should_not have_content "登录"
end

Then /^I should be signed out$/ do
  page.should have_content "登录"
  page.should_not have_content "退出"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "错误的用户名或密码"
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @admin[:name]
end
