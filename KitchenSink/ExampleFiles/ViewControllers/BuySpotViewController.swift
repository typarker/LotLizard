//
//  BuySpotViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Ty Parker on 1/15/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit
import MapKit

enum BuySpotViewControllerSection: Int {
    case LeftViewState
    case LeftDrawerAnimation
    case RightViewState
    case RightDrawerAnimation
}

class BuySpotViewController: ExampleViewController, UITableViewDataSource, MKMapViewDelegate {
    
    var tableView: UITableView!
    var mapView: MKMapView!
    
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
        
        var mapView = MKMapView()
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        // 2
        let span = MKCoordinateSpanMake(0.025, 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.mapType = .Standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
        
        
        
        //populateMap()
        
        /**self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight*/
        
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
        //self.tableView.backgroundView = backView
    }
    
    func populateMap(){
        mapView.removeAnnotations(mapView.annotations) // 1
        //let lots = Lot.allObjectsInRealm(realm)
        //var lotWithSpot = lots.objectsWhere("spots > 0")
        
        
        var query = PFQuery(className:"MyLotParse")
        query.whereKey("spots", greaterThan: 0)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) spots.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    let latitude = object["latitude"] as Double
                    let longitude = object["longitude"] as Double
                    let price = object["price"] as String
                    let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let id = object.objectId
                    let lotAnnotation = LotAnnotation(coordinate: coord, title: price, subtitle: "Dollars", id: id) // 3
                    self.mapView.addAnnotation(lotAnnotation) // 4
                    
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        //println(lots)
        // Create annotations for each one
        /*for lot in lotWithSpot {
        let aLot = lot as Lot
        let coord = CLLocationCoordinate2D(latitude: aLot.latitude, longitude: aLot.longitude);
        let lotAnnotation = LotAnnotation(coordinate: coord, title: String(aLot.price), subtitle: "Dollars", lot: aLot, id: aLot.id) // 3
        mapView.addAnnotation(lotAnnotation) // 4
        
        }
        
        println(lotWithSpot)
        */
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
        case CenterViewControllerSection.LeftDrawerAnimation.rawValue, CenterViewControllerSection.RightDrawerAnimation.rawValue:
            return 6
        case CenterViewControllerSection.LeftViewState.rawValue, CenterViewControllerSection.RightViewState.rawValue:
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
        case CenterViewControllerSection.LeftDrawerAnimation.rawValue, CenterViewControllerSection.RightDrawerAnimation.rawValue:
            var animationTypeForSection: DrawerAnimationType
            
            if indexPath.section == CenterViewControllerSection.LeftDrawerAnimation.rawValue {
                animationTypeForSection = ExampleDrawerVisualStateManager.sharedManager.leftDrawerAnimationType
            } else {
                animationTypeForSection = ExampleDrawerVisualStateManager.sharedManager.rightDrawerAnimationType
            }
            
            if animationTypeForSection.rawValue == indexPath.row {
                cell.accessoryType = .Checkmark
                cell.textLabel?.textColor = selectedColor
            } else {
                cell.accessoryType = .None
                cell.textLabel?.textColor = unselectedColor
            }
            
            switch indexPath.row {
            case DrawerAnimationType.None.rawValue:
                cell.textLabel?.text = "None"
            case DrawerAnimationType.Slide.rawValue:
                cell.textLabel?.text = "Slide"
            case DrawerAnimationType.SlideAndScale.rawValue:
                cell.textLabel?.text = "Slide and Scale"
            case DrawerAnimationType.SwingingDoor.rawValue:
                cell.textLabel?.text = "Swinging Door"
            case DrawerAnimationType.Parallax.rawValue:
                cell.textLabel?.text = "Parallax"
            case DrawerAnimationType.AnimatedBarButton.rawValue:
                cell.textLabel?.text = "Animated Menu Button"
            default:
                break
            }
        case CenterViewControllerSection.LeftViewState.rawValue:
            cell.textLabel?.text = "Enabled"
            
            if self.evo_drawerController?.leftDrawerViewController != nil {
                cell.accessoryType = .Checkmark
                cell.textLabel?.textColor = selectedColor
            } else {
                cell.accessoryType = .None
                cell.textLabel?.textColor = unselectedColor
            }
        case CenterViewControllerSection.RightViewState.rawValue:
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
        case CenterViewControllerSection.LeftDrawerAnimation.rawValue:
            return "Left Drawer Animation";
        case CenterViewControllerSection.RightDrawerAnimation.rawValue:
            return "Right Drawer Animation";
        case CenterViewControllerSection.LeftViewState.rawValue:
            return "Left Drawer";
        case CenterViewControllerSection.RightViewState.rawValue:
            return "Right Drawer";
        default:
            return nil
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case CenterViewControllerSection.LeftDrawerAnimation.rawValue, CenterViewControllerSection.RightDrawerAnimation.rawValue:
            if indexPath.section == CenterViewControllerSection.LeftDrawerAnimation.rawValue {
                ExampleDrawerVisualStateManager.sharedManager.leftDrawerAnimationType = DrawerAnimationType(rawValue: indexPath.row)!
            } else {
                ExampleDrawerVisualStateManager.sharedManager.rightDrawerAnimationType = DrawerAnimationType(rawValue: indexPath.row)!
            }
            
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case CenterViewControllerSection.LeftViewState.rawValue, CenterViewControllerSection.RightViewState.rawValue:
            var sideDrawerViewController: UIViewController?
            var drawerSide = DrawerSide.None
            
            if indexPath.section == CenterViewControllerSection.LeftViewState.rawValue {
                sideDrawerViewController = self.evo_drawerController?.leftDrawerViewController
                drawerSide = .Left
            } else if indexPath.section == CenterViewControllerSection.RightViewState.rawValue {
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
                    let navC = UINavigationController(rootViewController: vc)
                    self.evo_drawerController?.leftDrawerViewController = navC
                    self.setupLeftMenuButton()
                } else if drawerSide == .Right {
                    let vc = ExampleRightSideDrawerViewController()
                    let navC = UINavigationController(rootViewController: vc)
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
