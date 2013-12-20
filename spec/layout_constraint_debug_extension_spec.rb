describe "Moria::LayoutConstraintDebugExtension" do
  before do
    @subject = Object.new.extend(Moria::LayoutConstraintDebugExtension)
  end

  describe "#description_for_object" do
    it "should show readable description of view using moria_key" do
      view = UIView.new
      view.moria_key = "test"
      @subject.description_for_object(view).should.include "test"
    end
  end

  describe "#description" do
    it "should show priority" do
      view1 = UIView.new
      view1.moria_key = "view1"

      view2 = UIView.new
      view2.moria_key = "view2"

      constraint = Moria::LayoutConstraint.constraintWithItem(view1, attribute:NSLayoutAttributeTop, relatedBy:NSLayoutRelationEqual,
        toItem: view2, attribute: NSLayoutAttributeTop, multiplier: 1, constant: 10)

      desc = constraint.description
      desc.should.include "UIView:view1.top == UIView:view2.top + 10.0"
    end
  end
end