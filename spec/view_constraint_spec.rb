describe "Moria::ViewConstraint" do
  before do
    view = UIView.new
    @attribute1 = Moria::ViewAttribute.new(view, NSLayoutAttributeHeight)
    view2 = UIView.new
    @attribute2 = Moria::ViewAttribute.new(view2, NSLayoutAttributeHeight)
    @constraint = Moria::ViewConstraint.new(Moria::ViewAttribute.new(view, NSLayoutAttributeHeight))
  end

  describe "#==" do
    it "should return constraint with NSLayoutRelationEqual" do
      @constraint.==(@attribute2)

      @constraint.relation.should == NSLayoutRelationEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end
  end

  describe "#>=" do
    it "should return constraint with NSLayoutRelationGreaterThan" do
      @constraint.>=(@attribute2)

      @constraint.relation.should == NSLayoutRelationGreaterThanOrEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end
  end

  describe "#<=" do
    it "should return constraint with NSLayoutRelationLessThan" do
      @constraint.<=(@attribute2)

      @constraint.relation.should == NSLayoutRelationLessThanOrEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end
  end
end