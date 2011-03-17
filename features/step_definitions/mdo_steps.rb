
class Output < IO
  attr_reader :messages

  def initialize
    @messages = []
  end

  def puts(message)
    @messages << message
  end
end

def mdo
  @output ||= Output.new
  @tempfile ||= Tempfile.new("mdo")
  mdo = MDO::CLI.new([], { :output => @output, :location => @tempfile.path })
end

Given /^I have no lists$/ do
  # nothing to do here, it's just a placeholder
end

When /^I add the list "([^"]*)"$/ do |name|
  mdo.invoke(:add_list, [name])
end

Then /^I should see "([^"]*)"$/ do |message|
  @output.messages.should include(message)
end

Given /^I have the "([^"]*)" list$/ do |name|
  mdo.invoke(:add_list, [name])
end

When /^I add the "([^"]*)" element to the "([^"]*)" list$/ do |element, list|
  mdo.invoke(:add, [list, element])
end

