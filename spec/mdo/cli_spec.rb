require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module MDO
  describe CLI do
    let(:manager) { double("manager").as_null_object }
    subject { CLI.new }

    before(:each) do
      subject.stub(:manager).and_return(manager)
    end

    describe "#add" do
      it "should add an element" do
        manager.should_receive(:add).with("list", "element")
        subject.add("list", "element")
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
        manager.should_receive(:add_list).with("list")
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
