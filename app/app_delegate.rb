class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.window.backgroundColor = UIColor.whiteColor

    view_controller   = ExampleListController.alloc.init
    navController     = UINavigationController.alloc.initWithRootViewController(view_controller)
    self.window.rootViewController = navController
    self.window.makeKeyAndVisible
    true
  end
end
