describe "Moria::ViewConstraint" do
  before do
    @superview = UIView.new
    view = UIView.new
    view2 = UIView.new
    @superview.addSubview(view)
    @superview.addSubview(view2)
    @attribute1 = Moria::ViewAttribute.new(view, NSLayoutAttributeHeight)
    @attribute2 = Moria::ViewAttribute.new(view2, NSLayoutAttributeHeight)
    @constraint = Moria::ViewConstraint.new(Moria::ViewAttribute.new(view, NSLayoutAttributeHeight))
  end

  describe "#offset" do
    it "should return self with constant set" do
      @constraint.offset(10.0)
      @constraint.constant.should == 10.0
    end
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

  describe "#offset" do
    it "should add constraint with offset" do
      (@constraint >= @attribute2).with.offset(10)
      @constraint.install
      @constraint.constant.should == 10
    end
  end

  describe "#install" do
    it "should add constraint to superview" do
      @constraint >= @attribute2

      constraint = @constraint.install
      constraint.installed_view.should == @superview
      constraint.layout_constraint.should.not.be.nil
      constraint.layout_constraint.class.should == NSLayoutConstraint
    end

    it "should add constraint on attribute with offset" do
      @constraint.==(@attribute2.offset(10))
      @constraint.install
      @constraint.constant.should == 10
    end
  end
end