describe "Moria::ViewAttribute" do
  before do
    superview = UIView.alloc.init
    @view = UIView.alloc.init
    superview.addSubview(@view)
    @view_attribute = Moria::ViewAttribute.new(@view, NSLayoutAttributeLeft)
  end

  describe "#offset" do
    it "should set constant on view attribute" do
      @view_attribute.offset(10).should == @view_attribute
      @view_attribute.constant.should == 10
    end
  end
end