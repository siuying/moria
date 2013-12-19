class ExampleViewController < UIViewController
  attr_accessor :view_class
  def initWithTitle(title, view_class:view_class)
    self.init
    self.title = title
    self.view_class = view_class
    self
  end

  def loadView
    self.view = self.view_class.new
    self.view.backgroundColor = UIColor.whiteColor
  end

  def edgesForExtendedLayout
    UIRectEdgeNone
  end
end