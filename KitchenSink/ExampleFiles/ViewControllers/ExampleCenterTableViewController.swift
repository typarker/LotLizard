//
//  ExampleCenterTableViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Sascha Schwabbauer on 14.09.14.
//  Copyright (c) 2014 evolved.io. All rights reserved.
//

import UIKit

enum CenterViewControllerSection: Int {
    case LeftViewState
    case LeftDrawerAnimation
    case RightViewState
    case RightDrawerAnimation
}

class ExampleCenterTableViewController: ExampleViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.restorationIdentifier = "ExampleCenterControllerRestorationKey"
    }
    
    override init() {
        super.init()
        
        self.restorationIdentifier = "ExampleCenterControllerRestorationKey"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        let twoFingerDoubleTap = UITapGestureRecognizer(target: self, action: "twoFingerDoubleTap:")
        twoFingerDoubleTap.numberOfTapsRequired = 2
        twoFingerDoubleTap.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoFingerDoubleTap)
        
        self.setupLeftMenuButton()
        self.setupRightMenuButton()
        
        let barColor = UIColor(red: 247/255, green: 249/255, blue: 250/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = barColor
        
        self.navigationController?.view.layer.cornerRadius = 10.0
        
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        self.tableView.backgroundView = backView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("Center will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("Center did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("Center will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("Center did disappear")
    }
    
    func setupLeftMenuButton() {
        let leftDrawerButton = DrawerBarButtonItem(target: self, action: "leftDrawerButtonPress:")
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }
    
    func setupRightMenuButton() {
        let rightDrawerButton = DrawerBarButtonItem(target: self, action: "rightDrawerButtonPress:")
        self.navigationItem.setRightBarButtonItem(rightDrawerButton, animated: true)
    }
    
    override func contentSizeDidChange(size: String) {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CenterViewControllerSection.LeftDrawerAnimation.toRaw(), CenterViewControllerSection.RightDrawerAnimation.toRaw():
            return 5
        case CenterViewControllerSection.LeftViewState.toRaw(), CenterViewControllerSection.RightViewState.toRaw():
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = CenterTableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
            cell.selectionStyle = .Gray
        }
        
        let selectedColor = UIColor(red: 1 / 255, green: 15 / 255, blue: 25 / 255, alpha: 1.0)
        let unselectedColor = UIColor(red: 79 / 255, green: 93 / 255, blue: 102 / 255, alpha: 1.0)
        
        switch indexPath.section {
        case CenterViewControllerSection.LeftDrawerAnimation.toRaw(), CenterViewControllerSection.RightDrawerAnimation.toRaw():
            var animationTypeForSection: DrawerAnimationType
            
            if indexPath.section == CenterViewControllerSection.LeftDrawerAnimation.toRaw() {
                animationTypeForSection = ExampleDrawerVisualStateManager.sharedManager.leftDrawerAnimationType
            } else {
                animationTypeForSection = ExampleDrawerVisualStateManager.sharedManager.rightDrawerAnimationType
            }
            
            if animationTypeForSection.toRaw() == indexPath.row {
                cell.accessoryType = .Checkmark
                cell.textLabel?.textColor = selectedColor
            } else {
                cell.accessoryType = .None
                cell.textLabel?.textColor = unselectedColor
            }
            
            switch indexPath.row {
            case DrawerAnimationType.None.toRaw():
                cell.textLabel?.text = "None"
            case DrawerAnimationType.Slide.toRaw():
                cell.textLabel?.text = "Slide"
            case DrawerAnimationType.SlideAndScale.toRaw():
                cell.textLabel?.text = "Slide and Scale"
            case DrawerAnimationType.SwingingDoor.toRaw():
                cell.textLabel?.text = "Swinging Door"
            case DrawerAnimationType.Parallax.toRaw():
                cell.textLabel?.text = "Parallax"
            default:
                break
            }
        case CenterViewControllerSection.LeftViewState.toRaw():
            cell.textLabel?.text = "Enabled"
            
            if self.evo_drawerController?.leftDrawerViewController != nil {
                cell.accessoryType = .Checkmark
                cell.textLabel?.textColor = selectedColor
            } else {
                cell.accessoryType = .None
                cell.textLabel?.textColor = unselectedColor
            }
        case CenterViewControllerSection.RightViewState.toRaw():
            cell.textLabel?.text = "Enabled"
            
            if self.evo_drawerController?.rightDrawerViewController != nil {
                cell.accessoryType = .Checkmark
                cell.textLabel?.textColor = selectedColor
            } else {
                cell.accessoryType = .None
                cell.textLabel?.textColor = unselectedColor
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case CenterViewControllerSection.LeftDrawerAnimation.toRaw():
            return "Left Drawer Animation";
        case CenterViewControllerSection.RightDrawerAnimation.toRaw():
            return "Right Drawer Animation";
        case CenterViewControllerSection.LeftViewState.toRaw():
            return "Left Drawer";
        case CenterViewControllerSection.RightViewState.toRaw():
            return "Right Drawer";
        default:
            return nil
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case CenterViewControllerSection.LeftDrawerAnimation.toRaw(), CenterViewControllerSection.RightDrawerAnimation.toRaw():
            if indexPath.section == CenterViewControllerSection.LeftDrawerAnimation.toRaw() {
                ExampleDrawerVisualStateManager.sharedManager.leftDrawerAnimationType = DrawerAnimationType.fromRaw(indexPath.row)!
            } else {
                ExampleDrawerVisualStateManager.sharedManager.rightDrawerAnimationType = DrawerAnimationType.fromRaw(indexPath.row)!
            }
            
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case CenterViewControllerSection.LeftViewState.toRaw(), CenterViewControllerSection.RightViewState.toRaw():
            var sideDrawerViewController: UIViewController?
            var drawerSide = DrawerSide.None
            
            if indexPath.section == CenterViewControllerSection.LeftViewState.toRaw() {
                sideDrawerViewController = self.evo_drawerController?.leftDrawerViewController
                drawerSide = .Left
            } else if indexPath.section == CenterViewControllerSection.RightViewState.toRaw() {
                sideDrawerViewController = self.evo_drawerController?.rightDrawerViewController
                drawerSide = .Right
            }
            
            if sideDrawerViewController != nil {
                self.evo_drawerController?.closeDrawerAnimated(true, completion: { (finished) -> Void in
                    if drawerSide == DrawerSide.Left {
                        self.evo_drawerController?.leftDrawerViewController = nil
                        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
                    } else if drawerSide == .Right {
                        self.evo_drawerController?.rightDrawerViewController = nil
                        self.navigationItem.setRightBarButtonItems(nil, animated: true)
                    }
                    
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                    tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                })
            } else {
                if drawerSide == .Left {
                    let vc = ExampleLeftSideDrawerViewController()
                    let navC = NavigationController(rootViewController: vc)
                    self.evo_drawerController?.leftDrawerViewController = navC
                    self.setupLeftMenuButton()
                } else if drawerSide == .Right {
                    let vc = ExampleRightSideDrawerViewController()
                    let navC = NavigationController(rootViewController: vc)
                    self.evo_drawerController?.rightDrawerViewController = navC
                    self.setupRightMenuButton()
                }
                
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        default:
            break
        }
    }
    
    // MARK: - Button Handlers
    
    func leftDrawerButtonPress(sender: AnyObject?) {
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    func rightDrawerButtonPress(sender: AnyObject?) {
        self.evo_drawerController?.toggleDrawerSide(.Right, animated: true, completion: nil)
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        self.evo_drawerController?.bouncePreviewForDrawerSide(.Left, completion: nil)
    }
    
    func twoFingerDoubleTap(gesture: UITapGestureRecognizer) {
        self.evo_drawerController?.bouncePreviewForDrawerSide(.Right, completion: nil)
    }
}