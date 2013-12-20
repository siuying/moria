class ExampleConstantView < UIView
  def init
    super

    view1 = UIView.new
    view1.backgroundColor = UIColor.purpleColor
    self.addSubview view1

    view2 = UIView.new
    view2.backgroundColor = UIColor.orangeColor
    self.addSubview view2

    view1.create_constraint do
      top     == 20
      left    == 20
      bottom  == -20
      right   == -20
    end

    view2.create_constraint do
      centerY == 50
      centerX == 0
      width   == 200
      height  == 100
    end

    self
  end
end