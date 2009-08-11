Feature: Ooyala API

  Background:
    Given I wait 3 seconds
  
  Scenario: Query your videos
    When I request my videos
    Then I should receive my account data
    
  Scenario: Fetching thumbnails for a video
    When I request my videos
    And I request the thumbnails for the first one
    Then I should receive a list of thumbnails
  
  Scenario: Updating a video title
    When I request my videos
    And I update it's title
    Then it should succeed 