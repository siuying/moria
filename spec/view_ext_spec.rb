describe "View Extension" do
  before do
    superview = UIView.alloc.init
    @view = UIView.alloc.init
    superview.addSubview(@view)
  end

  describe "#layout" do
    it "should build constraint" do
      @view.layout do
        top     == superview.top
        left    == superview.left
        bottom  == superview.bottom
        right   == superview.right
      end
      @view.constraints.size.should == 4
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