require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module MDO
  describe List do
    let(:manager) { double("Manager").as_null_object }
    let(:list) { List.new("first", manager) }

    it "should have a name" do
      list.name.should == "first"
    end

    context "with no elements" do
      it "should add an element to that list" do
        manager.should_receive(:p).with("1: hello.")
        list.add("hello")
      end

      it "should not add an empty element to that list" do
        manager.should_receive(:p).with("Impossible to add a blank element to the 'first' list.")
        list.add("")
      end

      it "should not add a nil element to that list" do
        manager.should_receive(:p).with("Impossible to add a blank element to the 'first' list.")
        list.add(nil)
      end

      it "should display none" do
        manager.should_receive(:p).with("There are no elements.")
        list.display!
      end
    end

    context "with 1 element" do
      before(:each) do
        list.add("first_element")
      end

      it "should add another element changing the position" do
        manager.should_receive(:p).with("2: second_element.")
        list.add("second_element")
      end

      it "should display the element" do
        manager.should_receive(:p).with("1: first_element.")
        list.display!
      end
    end

    context "with 2 elements" do
      before(:each) do
        list.add("first_element")
        list.add("second_element")
      end

      it "should display the elements" do
        manager.should_receive(:p).with("1: first_element.").ordered
        manager.should_receive(:p).with("2: second_element.").ordered
        list.display!
      end
    end

    it "should not persist the manager to yaml" do
      list.to_yaml_properties.should_not include("@manager")
    end

    it { list.should respond_to(:manager) }
    it { list.should respond_to(:manager=) }

    it "should have the same manager that was passed to the constructor" do 
      list.manager.should == manager 
    end

    it "should be able to set the manager from the outside" do
      manager = double("new_manager")
      list.manager = manager
      list.manager.should == manager
    end
  end
end
