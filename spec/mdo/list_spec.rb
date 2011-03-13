require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module MDO
  describe List do
    let(:manager) { double("Manager").as_null_object }
    let(:list) { List.new(manager, "first") }

    context "with no elements" do
      it "should add an element to that list" do
        manager.should_receive(:p).with("Added the 'hello' element to the 'first' list in position 1.")
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
    end

    context "with 1 element" do
      before(:each) do
        list.add("first_element")
      end

      it "should add another element changing the position" do
        manager.should_receive(:p).with("Added the 'second_element' element to the 'first' list in position 2.")
        list.add("second_element")
      end
    end
  end
end
