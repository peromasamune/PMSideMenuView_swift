# PMSideMenuView_swift

##  

![Screen1](https://github.com/peromasamune/PMSideMenuView/blob/master/screens/screen1.png?raw=true)

swift based popular side menu view.  

- Support pan gesture open/close menu
- Random generate background gradient
- Customizable sidemenu cells

# How to use

##

 - Create object and set to window
 
 ```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        var viewController = PMSideMenuViewController.sharedController
        viewController.delegate = self
        viewController.currentSideMenuIndex = 1

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
```

- Implement delegate methods

```swift
    func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger
    func PMSideMenuListItemAtIndex(index : NSInteger) -> PMSideMenuListItem?
    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController : PMSideMenuViewController, index : NSInteger) -> UIViewController?
```

__Examples__

```swift
func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger {
        return 4
    }

    func PMSideMenuListItemAtIndex(index: NSInteger) -> PMSideMenuListItem? {

        if (index == 0){
            var item : PMSideMenuListItem = PMSideMenuListItem.itemWith("PMSideMenuView", image: "icon.jpg")
            item.type = PMSideMenuListItemType.CircleImage
            item.cellHeight = 200;
            return item
        }

        if (index == 1){
            return PMSideMenuListItem.itemWith("Menu 1", image: "menu")
        }

        if (index == 2){
            return PMSideMenuListItem.itemWith("Menu 2", image: "menu")
        }

        if (index == 3){
            return PMSideMenuListItem.itemWith("Menu 3", image: "menu")
        }

        return nil
    }

    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController: PMSideMenuViewController, index: NSInteger) -> UIViewController? {

        if (index == 0){
            return nil
        }

        var itemViewController = ViewController()
        itemViewController.title = NSString(format: "Menu %ld", index)

        return itemViewController
    }
```

##License
Copyright &copy; 2015 Peromasamune  
Distributed under the [MIT License][mit].
[MIT]: http://www.opensource.org/licenses/mit-license.php 