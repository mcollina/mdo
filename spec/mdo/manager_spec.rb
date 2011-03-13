require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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

      it "should automatically create a list when adding an element" do
        output.should_receive(:puts).with("Created a new list named 'first'.")
        manager.add("first", "element")
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
    end
  end
end
