Feature: Ooyala API

  Background:
    Given I wait a few seconds
    When I request my videos
  
  Scenario: Query your videos
    Then I should receive my account data
     
  Scenario: Fetching thumbnails for a video
    When I request the thumbnails for the first one
    Then I should receive a list of thumbnails
   
  Scenario: Updating a video title
    When I update it's title
    Then it should succeed

  Scenario: Add metadata to a video
    When I update the genre
    Then it should succeed
    
  Scenario: Search metadata for a video
    When I query its metadata
    Then I should have some metadata
    
  Scenario: Delete metadata for a video
    When I query its metadata
    And delete one guid of metadata
    Then that metadata should be deleted
    
  Scenario: Delete metadata for a query
    When I do a query to delete all metadata
    Then it should succeed
    