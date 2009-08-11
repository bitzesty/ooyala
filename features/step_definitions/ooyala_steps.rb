Given /^I wait a few seconds$/ do
  sleep 5.5
end

When /^I request my videos$/ do
  @responce = Video.query
  @responce.should_not == "signature mismatch"
  if @responce["list"]["size"].to_i > 1
    @video = @responce["list"]["item"][0]
  else
    @video = @responce["list"]["item"]
  end
end

Then /^I should receive my account data$/ do
  @responce['list']['pageID'].should == "0"
end

When /^I request the thumbnails for the first one$/ do
  sleep 6.0
  @responce = Video.thumbnails(@video["embedCode"])
  @responce.should_not == "signature mismatch"
end

Then /^I should receive a list of thumbnails$/ do
  @responce["thumbnails"]["thumbnail"].size.should >= 1
end

When /^I update it's title$/ do
  sleep 6.0
  @responce = Video.edit(@video["embedCode"], {"title" => "#{@video["title"]}_updated"})
  @responce.should_not == "signature mismatch"
end

When /^I update the genre$/ do
  sleep 6.0
  @responce = Video.metadata(@video["embedCode"], "add", {"genre" => "Films"})
  @responce.should_not == "signature mismatch"
end

When /^I query its metadata$/ do
  pending
end

Then /^I should have some metadata$/ do
  pending
end

When /^delete one guid of metadata$/ do
  pending
end

Then /^that metadata should be deleted$/ do
  pending
end

When /^I do a query to delete all metadata$/ do
  pending
end



Then /^it should succeed$/ do
  @responce.should == "ok"
end

