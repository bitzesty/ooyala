Given /^I wait 3 seconds$/ do
  sleep 5
end

When /^I request my videos$/ do
  @responce = Video.query
end

Then /^I should receive my account data$/ do
  @responce.should_not == "signature mismatch"
  @responce['list']['pageID'].should == "0"
end

When /^I request the thumbnails for the first one$/ do
  @responce.should_not == "signature mismatch"
  if @responce["list"]["size"].to_i > 1
    @video = @responce["list"]["item"][0]
  else
    @video = @responce["list"]["item"]
  end
  
  @responce = Video.thumbnails(@video["embedCode"])
end

Then /^I should receive a list of thumbnails$/ do
  @responce.should_not == "signature mismatch"  
  @responce["thumbnails"]["thumbnail"].size.should >= 1
end
