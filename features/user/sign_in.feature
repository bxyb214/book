Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: admin signs in successfully
      Given I exist as a admin
      And I am not logged in
      When I sign in with valid credentials
      Then I should be signed in
      
    Scenario: admin enters wrong password
      Given I exist as a admin
      And I am not logged in
      When I sign in with a wrong username
      Then I see an invalid login message
      And I should be signed out

    Scenario: admin enters wrong email
      Given I exist as a admins
      And I am not logged in
      When I sign in with a wrong password
      Then I see an invalid login message
      And I should be signed out