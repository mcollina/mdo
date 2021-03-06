require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'stringio'

module MDO
  describe Manager do

    let(:output) { double("Output").as_null_object }
    let(:manager) { Manager.new(output) }

    context "with no lists" do
      it "should add a list with name 'first'" do
        output.should_receive(:puts).with("Created a new list named 'first'.")
        manager.add("first")
      end

      it "should not add an empty list" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.add("")
      end

      it "should not add a nil list" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.add(nil)
      end

      it "should automatically create a list when we search for it but it doesn't exists" do
        output.should_receive(:puts).with("Created a new list named 'first'.")
        manager.find("first")
      end

      it "should not automatically create a list if it has a blank name" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.find("")
      end

      it "should calls add if no list was found" do
        manager.should_receive(:add).with("first").and_return(:list)
        manager.find("first").should == :list
      end

      it "should display no lists." do
        output.should_receive(:puts).with("There are no lists.")
        manager.display!
      end
    end

    context "with 1 list" do
      before(:each) do
        manager.add("first")
      end

      it "should not add another list with the same name" do
        output.should_receive(:puts).with("There is already a list named 'first'.")
        manager.add("first")
      end

      it "should add another list" do
        output.should_receive(:puts).with("Created a new list named 'second'.")
        manager.add("second")
      end

      it "should find it" do
        manager.find("first").should_not be_nil
      end

      it "should be persistable" do
        io = StringIO.new
        manager.stub(:open).with("dest", "w").and_yield(io)
        manager.save("dest")

        io.rewind

        new_output = double("new_output")
        other = Manager.new(new_output)
        other.stub(:open).with("dest").and_yield(io)
        other.load("dest")

        new_output.should_receive(:puts).with("There is already a list named 'first'.")
        other.add("first")
      end

      it "should reset the manager on persist" do
        io = StringIO.new
        manager.stub(:open).with("dest", "w").and_yield(io)
        manager.save("dest")

        io.rewind

        other = Manager.new(output)
        other.stub(:open).with("dest").and_yield(io)
        other.load("dest")

        other["first"].manager.should == other
      end

      it "should display the list" do
        output.should_receive(:puts).with("1: first.")
        manager.display!
      end

      it "should get the list by name" do
        manager["first"].should == manager.find("first")
      end
    end

    context "with 2 lists" do
      before(:each) do
        manager.add("first")
        manager.add("second")
      end

      it "should display the lists" do
        output.should_receive(:puts).with("1: first.").ordered
        output.should_receive(:puts).with("2: second.").ordered
        manager.display!
      end
    end

    it "should load an empty file" do
      other = Manager.new(output)
      other.stub(:open).with("dest").and_yield(StringIO.new)
      expect { other.load("dest") }.should_not raise_error
    end

    it "should get no value when getting a non-existent list" do
      output.should_not_receive(:puts)
      manager["a_list"]
    end

    it "should get nil when getting a non-existitent list" do
      manager["a_list"].should be_nil
    end
  end
end
