class ExampleBasicView < UIView
  def init
    super

    view1 = UIView.new
    view1.backgroundColor = UIColor.greenColor
    self.addSubview view1

    view2 = UIView.new
    view2.backgroundColor = UIColor.redColor
    self.addSubview view2

    view3 = UIView.new
    view3.backgroundColor = UIColor.blueColor
    self.addSubview view3
    padding = 10

    view1.create_constraint do
      top     >= superview.top.offset(padding)
      left    == (superview.left).offset(padding)
      bottom  == (view3.top).offset(-padding)
      right   == (view2.left).offset(-padding)
      width   == view2.width
      height  == view2.height
      height  == view3.height
    end

    view2.create_constraint do
      top     >= (superview.top).offset(padding)
      left    == (view1.right).offset(padding)
      bottom  == (view3.top).offset(-padding)
      right   == (superview.right).offset(-padding)
      width   == view1.width
      height  == view1.height
      height  == view3.height
    end

    view3.create_constraint do
      top     >= (view1.bottom).offset(padding)
      left    == (superview.left).offset(padding)
      bottom  == (superview.bottom).offset(-padding)
      right   == (superview.right).offset(-padding)
      height  == view1.height
      height  == view2.height
    end

    self
  end
end