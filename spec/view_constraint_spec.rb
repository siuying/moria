describe "Moria::ViewConstraint" do
  before do
    @superview = UIView.new
    @view1 = UIView.new
    @view2 = UIView.new
    @superview.addSubview(@view1)
    @superview.addSubview(@view2)
    @attribute1 = Moria::ViewAttribute.new(@view1, NSLayoutAttributeHeight)
    @attribute2 = Moria::ViewAttribute.new(@view2, NSLayoutAttributeHeight)
    @constraint = Moria::ViewConstraint.new(@attribute1)
  end

  describe "#offset" do
    it "should return self with constant set" do
      @constraint.offset(10.0)
      @constraint.layout_constant.should == 10.0
    end
  end

  describe "#priority" do
    it "should return self with priority set" do
      @constraint.priority(10.0)
      @constraint.layout_priority.should == 10.0
    end
  end

  describe "#priority_high" do
    it "should return self with priority set as UILayoutPriorityDefaultHigh" do
      @constraint.priority_high
      @constraint.layout_priority.should == UILayoutPriorityDefaultHigh
    end
  end

  describe "#priority_low" do
    it "should return self with priority set as UILayoutPriorityDefaultLow" do
      @constraint.priority_low
      @constraint.layout_priority.should == UILayoutPriorityDefaultLow
    end
  end

  describe "#==" do
    it "should return constraint with NSLayoutRelationEqual" do
      @constraint.==(@attribute2)

      @constraint.layout_relation.should == NSLayoutRelationEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end

    it "should return constraint with == constant relation" do
      @constraint == 10
      @constraint.layout_relation.should == NSLayoutRelationEqual
      @constraint.layout_constant.should == 10
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == nil
    end
  end

  describe "#>=" do
    it "should return constraint with NSLayoutRelationGreaterThan" do
      @constraint.>=(@attribute2)

      @constraint.layout_relation.should == NSLayoutRelationGreaterThanOrEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end

    it "should return constraint with >= constant relation" do
      @constraint >= 10
      @constraint.layout_relation.should == NSLayoutRelationGreaterThanOrEqual
      @constraint.layout_constant.should == 10
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == nil
    end
  end

  describe "#<=" do
    it "should return constraint with NSLayoutRelationLessThan" do
      @constraint.<=(@attribute2)

      @constraint.layout_relation.should == NSLayoutRelationLessThanOrEqual
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == @attribute2
    end

    it "should return constraint with <= constant relation" do
      @constraint <= 10
      @constraint.layout_relation.should == NSLayoutRelationLessThanOrEqual
      @constraint.layout_constant.should == 10
      @constraint.first_view_attribute.should == @attribute1
      @constraint.second_view_attribute.should == nil
    end
  end

  describe "#offset" do
    it "should add constraint with offset" do
      (@constraint >= @attribute2).with.offset(10)
      @constraint.install
      @constraint.layout_constant.should == 10
    end
  end

  describe "#install" do
    it "should add constraint to superview" do
      @constraint >= @attribute2

      constraint = @constraint.install
      constraint.installed_view.should == @superview
      constraint.layout_constraint.should.not.be.nil
      constraint.layout_constraint.should.is_a NSLayoutConstraint
    end

    it "should add constraint on attribute with offset" do
      @constraint.==(@attribute2.offset(10))
      @constraint.install
      @constraint.layout_constant.should == 10
    end

    it "should add constraint to superview, if it is constant constraint on aligment attribute" do
      @attribute1 = Moria::ViewAttribute.new(@view1, NSLayoutAttributeCenterX)
      @constraint = Moria::ViewConstraint.new(@attribute1)

      @constraint.==(10)
      @constraint.install
      @constraint.layout_constant.should == 10
      @constraint.layout_constraint.firstItem.should == @view1
      @constraint.layout_constraint.secondItem.should == @superview
    end
  end

  describe "#uninstall" do
    it "should remove constraint" do
      @constraint >= @attribute2
      @constraint.install
      @constraint.uninstall
      @superview.constraints.size.should == 0
      @constraint.installed_view.should == nil
      @constraint.layout_constraint.should == nil
    end

  end
end