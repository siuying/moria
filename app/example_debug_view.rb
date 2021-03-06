class ExampleDebugView < UIView
  def init
    super

    view1 = UIView.new
    view1.backgroundColor = UIColor.greenColor
    addSubview view1

    view2 = UIView.new
    view2.backgroundColor = UIColor.redColor
    addSubview view2

    view3 = UILabel.new
    view3.backgroundColor = UIColor.blueColor
    view3.numberOfLines = 3;
    view3.textAlignment = NSTextAlignmentCenter;
    view3.font = UIFont.systemFontOfSize(24)
    view3.textColor = UIColor.whiteColor
    view3.text = "this should look broken! check your console!"
    addSubview view3

    # install debug extension to NSConstraint, make the debug output more readable
    Moria.install_debug_extension

    # you can attach debug keys to views
    view1.moria_key = "view1"
    view2.moria_key = "view2"
    view3.moria_key = "view3"
    self.moria_key = "superview"

    padding = 10
    view3.create_constraint do
      (height >= 5000).key("ConstantConstraint") # attache keys to constraint

      top == superview.top.offset(1)
      left == superview.left.offset(1)
      bottom == superview.bottom.offset(-1)
      right == superview.right.offset(-1)

      top == view1.bottom.offset(padding)
      left == superview.left.offset(padding)
      bottom == superview.bottom.offset(-padding)
      right == superview.right.offset(-padding)

      height == view1.height
      height == view2.height
    end

    view1.create_constraint do
      top == superview.top.offset(padding)
      left == superview.left.offset(padding)
      bottom == view3.top.offset(-padding)
      right == view2.left.offset(-padding)
      width == view2.width

      height == view3.height
      height == view2.height
    end

    view2.create_constraint do
      top == superview.top.offset(padding)
      left == view1.right.offset(padding)
      bottom == view3.top.offset(-padding)
      right == superview.right.offset(-padding)
      width == view1.width

      height == view1.height
      height == view3.height
    end

    self
  end
end