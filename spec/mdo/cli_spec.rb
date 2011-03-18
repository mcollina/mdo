require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module MDO
  describe CLI do
    let(:manager) { double("manager").as_null_object }
    subject { CLI.new }

    before(:each) do
      subject.stub(:manager).and_return(manager)
    end

    describe "#add" do
      before(:each) do
        @list = double("list").as_null_object
        manager.stub(:find).with("list").and_return(@list)
      end

      it "should add an element" do
        @list.should_receive(:add).with("element")
        subject.add("list", "element")
      end

      it "should not add an element if the list wasn't found" do
        manager.stub(:find).with("another_list").and_return(nil)
        expect { subject.add("another_list", "element") }.should_not raise_error
      end

      it "should load and save the manager from the default configuration" do
        File.stub!(:exists?).and_return(true)
        manager.should_receive(:load).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        subject.add("list", "element")
      end

      it "should not load but save the manager if the default location doesn't exists" do
        File.stub!(:exists?).and_return(false)
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo"))
        subject.add("list", "element")
      end
    end

    describe "#show" do
      before(:each) do
        @list = double("list").as_null_object
        manager.stub(:find).with("list").and_return(@list)
      end

      it "should display an element" do
        @list.should_receive(:display!)
        subject.show("list")
      end

      it "should load and save the manager from the default configuration" do
        File.stub!(:exists?).and_return(true)
        manager.should_receive(:load).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        subject.add("list", "element")
      end

      it "should not load but save the manager if the default location doesn't exists" do
        File.stub!(:exists?).and_return(false)
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo"))
        subject.add("list", "element")
      end
    end

    describe "#add_list" do
      it "should add a list" do
        manager.should_receive(:add).with("list")
        subject.add_list("list")
      end

      it "should load and save the manager from the default configuration" do
        File.stub!(:exists?).and_return(true)
        manager.should_receive(:load).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo")).ordered
        subject.add_list("list")
      end

      it "should not load but save the manager if the default location doesn't exists" do
        File.stub!(:exists?).and_return(false)
        manager.should_receive(:save).with(File.join(MDO.user_home_dir, ".mdo"))
        subject.add_list("list")
      end
    end
  end
end
