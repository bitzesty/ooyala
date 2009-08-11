When /^I request a blank query$/ do
  @responce = Video.query
end

Then /^I should receive my account data$/ do
  @responce.should_not == "signature mismatch"
  @responce['list']['pageID'].should == "0"
end
