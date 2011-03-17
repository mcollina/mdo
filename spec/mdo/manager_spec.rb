require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'stringio'

module MDO
  describe Manager do

    let(:output) { double("Output").as_null_object }
    let(:manager) { Manager.new(output) }

    context "with no lists" do
      it "should add a list with name 'first'" do
        output.should_receive(:puts).with("Created a new list named 'first'.")
        manager.add_list("first")
      end

      it "should not add an empty list" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.add_list("")
      end

      it "should not add a nil list" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.add_list(nil)
      end

      it "should automatically create a list when we search for it but it doesn't exists" do
        output.should_receive(:puts).with("Created a new list named 'first'.")
        manager.find("first")
      end

      it "should not automatically create a list if it has a blank name" do
        output.should_receive(:puts).with("Impossible to add a list with blank name.")
        manager.find("")
      end

      it "should calls add_list if no list was found" do
        manager.should_receive(:add_list).with("first").and_return(:list)
        manager.find("first").should == :list
      end
    end

    context "with 1 list" do
      before(:each) do
        manager.add_list("first")
      end

      it "should not add another list with the same name" do
        output.should_receive(:puts).with("There is already a list named 'first'.")
        manager.add_list("first")
      end

      it "should add another list" do
        output.should_receive(:puts).with("Created a new list named 'second'.")
        manager.add_list("second")
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
        other.add_list("first")
      end

      it "should reset the manager on persist" do
        io = StringIO.new
        manager.stub(:open).with("dest", "w").and_yield(io)
        manager.save("dest")

        io.rewind

        other = Manager.new(output)
        other.stub(:open).with("dest").and_yield(io)
        other.load("dest")

        other.lists["first"].manager.should == other
      end
    end

    it "should load an empty file" do
      other = Manager.new(output)
      other.stub(:open).with("dest").and_yield(StringIO.new)
      expect { other.load("dest") }.should_not raise_error
    end
  end
end
