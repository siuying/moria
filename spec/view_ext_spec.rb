describe "View Extension" do
  before do
    superview = UIView.alloc.init
    @view = UIView.alloc.init
    superview.addSubview(@view)
  end

  describe "#layout" do
    it "should build constraints on view" do
      @view.superview.constraints.size.should == 0
      @view.layout do
        top     == superview.top.offset(10)
        left    == superview.left
        bottom  == superview.bottom
        right   == superview.right
        width   == 140
        (height  <= 140).priority_low
      end
      @view.superview.constraints.size.should == 4
      @view.constraints.size.should == 2
    end

    it "should set view translatesAutoresizingMaskIntoConstraints to false" do
      @view.layout do
      end
      @view.translatesAutoresizingMaskIntoConstraints.should.be.false
    end
  end

  describe "#closest_common_superview" do
    it "should return self if input is self" do
      superview = UIView.new
      superview.closest_common_superview(superview).should == superview
    end

    it "should find super view of parent/child view" do
      superview = UIView.new
      subview1 = UIView.new
      superview.addSubview subview1
      subview1.closest_common_superview(superview).should == superview
      superview.closest_common_superview(subview1).should == superview
    end

    it "should find super view of sibling views" do
      superview = UIView.new
      subview1 = UIView.new
      subview2 = UIView.new
      superview.addSubview subview1
      superview.addSubview subview2
      subview1.closest_common_superview(subview2).should == superview
      subview2.closest_common_superview(subview1).should == superview
    end

    it "should find super view of views in different level" do
      superview = UIView.new
      subview1 = UIView.new
      subview2 = UIView.new
      superview.addSubview subview1
      superview.addSubview subview2
      subview3 = UIView.new
      subview4 = UIView.new
      subview2.addSubview subview3
      subview2.addSubview subview4

      subview1.closest_common_superview(subview3).should == superview
      subview3.closest_common_superview(subview1).should == superview
      subview4.closest_common_superview(subview3).should == subview2
      subview3.closest_common_superview(subview4).should == subview2
    end
  end

  Moria::LAYOUT_ATTRIBUTES.each do |name, layout_attribute|
    describe "##{name}" do
      it "should return attribute" do
        view_attribute = @view.send(name)
        view_attribute.class.should == Moria::ViewAttribute
        view_attribute.view.should == @view
        view_attribute.layout_attribute.should == layout_attribute
      end
    end
  end
end