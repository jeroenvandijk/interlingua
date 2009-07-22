Given /^I have ran "([^\"]*)"$/ do |command|
  run(command)
end

When /^I run "([^\"]*)"$/ do |command|
  run(command)
end

Then /^I should see$/ do |string|
  last_stderr.should == ""
  last_stdout.should == string
  last_exit_status.should == 0
end

Then /^I should have a file "([^\"]*)" with:$/ do |file_name, file_contents|
  in_current_dir do
    File.open(file_name, 'r') {|f| f.read.should == file_contents }
  end
end

Given /^I have a file "([^\"]*)" with:$/ do |file_name, file_contents|
  create_file(file_name, file_contents)
end
