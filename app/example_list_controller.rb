class ExampleListController < UITableViewController
  ExampleListControllerCellIdentifier = "ExampleListController"
  attr_accessor :example_controllers

  def init
    super
    self.title = "Examples"
    self.example_controllers = [
      ExampleViewController.alloc.initWithTitle("Basic Example", view_class: ExampleBasicView)
    ]
    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor
    self.tableView.registerClass(UITableViewCell, forCellReuseIdentifier:ExampleListControllerCellIdentifier)
  end

  # UITableViewDataSource

  def tableView(table, cellForRowAtIndexPath: index_path)
    view_controller = self.example_controllers[index_path.row]
    cell = table.dequeueReusableCellWithIdentifier(ExampleListControllerCellIdentifier, forIndexPath: index_path)
    cell.textLabel.text = view_controller.title
    return cell
  end

  def tableView(table, numberOfRowsInSection: section)
    self.example_controllers.size
  end

  # UITableViewDelegate

  def tableView(table, didSelectRowAtIndexPath:index_path)
    view_controller = self.example_controllers[index_path.row]
    self.navigationController.pushViewController(view_controller, animated:true)
  end
end