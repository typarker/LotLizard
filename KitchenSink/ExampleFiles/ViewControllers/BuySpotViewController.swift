//
//  BuySpotViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Ty Parker on 1/15/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit
import MapKit



class BuySpotViewController: UIViewController, MKMapViewDelegate {
    
    
    var mapView: MKMapView!
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Reserve a Spot"
        
        self.mapView = MKMapView()
        
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
        //self.setupRightMenuButton()
        
        let barColor = UIColor(red: 247/255, green: 249/255, blue: 250/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = barColor
        
        self.navigationController?.view.layer.cornerRadius = 10.0
        
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        //self.tableView.backgroundView = backView
        populateMap()
        
    }
    
    func populateMap(){
        self.mapView.removeAnnotations(mapView.annotations) // 1
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
                    let location = object ["location"] as PFGeoPoint
                    let latitude = location.latitude as Double
                    let longitude = location.longitude as Double
                    let price = object["price"] as String
                    let owner = object["owner"] as PFUser?
                    let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let id = object.objectId
                    let notes = object["notes"] as String?
                    let spots = object["spots"] as Int
                    let lotAnnotation = LotAnnotation(coordinate: coord, title: price, subtitle: "Dollars", id: id, owner: owner!, notes: notes, spots: spots) // 3
                    self.mapView.addAnnotation(lotAnnotation) // 4
                    
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

        
    }
    
    func mapView(_mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
     
        let reuseId = "test"
        let button : UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.image = UIImage(named:"redPin.png")
            anView.canShowCallout = true
            anView.rightCalloutAccessoryView = button
            
            button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView.annotation = annotation
        }
        
        return anView
    }

    
    func buttonClicked(sender: UIButton!) {
        
        
        let ann = self.mapView.selectedAnnotations[0] as LotAnnotation
        
                
        let secondViewController: PurchaseSpotViewController = PurchaseSpotViewController(nibName:"PurchaseSpot", bundle: nil)
        secondViewController.latitude = ann.coordinate.latitude
        secondViewController.longitude = ann.coordinate.longitude
        secondViewController.ann = ann
        //let secondViewController: BuySpotViewController = BuySpotViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        //performSegueWithIdentifier("goToAddLot", sender: sender)
        
    
        
    
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
