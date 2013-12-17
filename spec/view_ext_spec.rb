describe "ViewExt" do
  describe "#layout" do
    it "should build constraint" do
      superview = UIView.alloc.init
      view = UIView.alloc.init
      superview.addSubview(view)

      view.layout do
        top     == superview.top
        left    == superview.left
        bottom  == superview.bottom
        right   == superview.right
      end
    end
  end
end