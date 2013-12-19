class AppDelegate
  attr_accessor :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.window.backgroundColor = UIColor.whiteColor

    exampleController = ExampleViewController.alloc.initWithTitle("Basic Example", view_class: ExampleBasicView)
    navController = UINavigationController.alloc.initWithRootViewController(exampleController)
    self.window.rootViewController = navController
    self.window.makeKeyAndVisible
    true
  end
end
