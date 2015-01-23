//
//  SellSpotViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Ty Parker on 1/16/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit
import MapKit



class SellSpotViewController: UIViewController, MKMapViewDelegate, PFLogInViewControllerDelegate {
    
    
    var mapView: MKMapView!
    //long press
    var coordToPass = CLLocationCoordinate2D(
        latitude: 0,
        longitude: 0
    )
    
    var currentUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sell Your Spot"
    
        self.mapView = MKMapView()
        
        
        
        if currentUser != nil {   // is user already signed in
            // Do stuff with the user
            populateMap()
        } else {
            // Show the signup or login screen
            var logInController = PFLogInViewController()
            logInController.delegate = self
            logInController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
            self.presentViewController(logInController, animated:true, completion: nil)
        }
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 0.5;
        
        mapView.addGestureRecognizer(lpgr)
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: 29.6520,
            longitude: -82.35
        )
        // 2
        let span = MKCoordinateSpanMake(0.025, 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.mapType = .Standard
        self.mapView.frame = view.frame
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        
        
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
        //populateMap()
        
    }
    
    //Dismiss Login View Controller after Login
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        populateMap()
        
        //matching user to device
        let currentInstallation: PFInstallation = PFInstallation.currentInstallation()
        var user = PFUser.currentUser()
        currentInstallation.setObject(user, forKey: "user")
        currentInstallation.saveInBackground()
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        //performSegueWithIdentifier("startAgainID", sender: self)
        
    }
    
    
        

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if segue.identifier == "goToAddLot"{
//            var newProjectVC:AddLotViewController = AddLotViewController()
//            newProjectVC = segue.destinationViewController as AddLotViewController
//            newProjectVC.latitude = self.coordToPass.latitude
//            newProjectVC.longitude = self.coordToPass.longitude
//        }
//    }
    
    
    class MapPin : NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String
        var subtitle: String
        
        
        
        init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            
        }
    }
    
    
    
    func mapView(_mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        //if !(annotation is MKPointAnnotation) {
        //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
        //return nil so map draws default view for it (eg. blue dot)...
        // return nil
        // }
        //let textbox : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
        //textbox.text = "blah"
        let reuseId = "test"
        let button : UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.image = UIImage(named:"redPin.png")
            anView.canShowCallout = true
            
            
            //anView.leftCalloutAccessoryView = textbox
            
            //price = self.textbox.text
            anView.rightCalloutAccessoryView = button
            
            button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView.annotation = annotation
        }
        
        return anView
    }
    
    //long press annotation add
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        //Remove any annotations
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        //Add new annotation
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        var info2 = MapPin(coordinate: newCoord,title: "Your Yard",subtitle: "")
        //var anView:MKAnnotationView! = mapView(self.mapView, viewForAnnotation: info2)
        self.mapView.addAnnotation(info2)
        coordToPass=newCoord
        
    }
    // Do any additional setup after loading the view.
    
    
    func buttonClicked(sender: UIButton!) {
        
        let secondViewController: AddLotWithXIBViewController = AddLotWithXIBViewController(nibName:"AddLotWithXIBViewController", bundle: nil)
        secondViewController.latitude = coordToPass.latitude
        secondViewController.longitude = coordToPass.longitude
        //let secondViewController: BuySpotViewController = BuySpotViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        //performSegueWithIdentifier("goToAddLot", sender: sender)
        
    }
    
    
    //add annotations to map
    func populateMap(){
        mapView.removeAnnotations(mapView.annotations) // 1
        
        var user = PFUser.currentUser()
        
        var query = PFQuery(className:"MyLotParse")
        query.whereKey("user", equalTo: user.username)
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
    }
    


    func setupLeftMenuButton() {
        let leftDrawerButton = DrawerBarButtonItem(target: self, action: "leftDrawerButtonPress:")
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }
    
    func setupRightMenuButton() {
        let rightDrawerButton = DrawerBarButtonItem(target: self, action: "rightDrawerButtonPress:")
        self.navigationItem.setRightBarButtonItem(rightDrawerButton, animated: true)
    }
    
    
    
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

