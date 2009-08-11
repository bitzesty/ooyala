Feature: Query API
To request information about content in a Backlot account

  Scenario: Query your videos
    When I request a blank query 
    Then I should receive my account data
    

