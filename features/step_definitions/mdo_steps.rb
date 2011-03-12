
class Output
  attr_reader :messages

  def initialize
    @messages = []
  end

  def puts(message)
    @messages << message
  end
end

def mdo
  return @mdo if @mdo
  @output = Output.new
  @mdo ||= MDO::Manager.new(@output)
end

Given /^I have no lists$/ do
  # nothing to do here, it's just a placeholder
end

When /^I add the list "([^"]*)"$/ do |name|
  mdo.add_list name
end

Then /^I should see "([^"]*)"$/ do |message|
  @output.messages.should include(message)
end

Given /^I have the "([^"]*)" list$/ do |name|
  mdo.add_list name
end

When /^I add the "([^"]*)" element to the "([^"]*)" list$/ do |list, element|
  mdo.add(list, element)
end

