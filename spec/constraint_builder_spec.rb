describe "ConstraintBuilder" do
  before do
    @superview = UIView.alloc.init
    @view = UIView.alloc.init
    @superview.addSubview(@view)
    @builder = Moria::ConstraintBuilder.new(@view)
  end
  
  describe "#superview" do
    it "should return superview of view" do
      @builder.superview.should == @superview
    end
  end

  describe "#install" do
    it "should install each of the constraints" do
      constraint = mock(:install, :return => true)

      @builder.constraints = [constraint]
      @builder.install.should == [constraint]
    end
  end

  describe "#top" do
    it "should add top constraint to builder" do
      @builder.instance_eval do
        top == superview.top
      end
      @builder.constraints.count.should == 1

      constraint = @builder.constraints.first
      constraint.first_view_attribute.view.should == @view
      constraint.first_view_attribute.layout_attribute.should == NSLayoutAttributeTop
      constraint.layout_relation.should == NSLayoutRelationEqual
      constraint.second_view_attribute.view.should == @view.superview
      constraint.second_view_attribute.layout_attribute.should == NSLayoutAttributeTop
    end
  end
end