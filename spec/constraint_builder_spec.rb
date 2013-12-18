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

  describe "#top" do
    it "should add top constraint to builder" do
      @builder.instance_eval do
        top == superview.top
      end
      @builder.constraints.count.should == 1
    end
  end
end