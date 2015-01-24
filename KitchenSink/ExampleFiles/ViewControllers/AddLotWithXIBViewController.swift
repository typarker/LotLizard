//
//  AddLotWithXIBViewController.swift
//  LotLizard
//
//  Created by Ty Parker on 1/23/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit
import MapKit

class AddLotWithXIBViewController: UIViewController, PFLogInViewControllerDelegate, MKMapViewDelegate {
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func tap(sender: AnyObject) {
        self.view.endEditing(true);
        println("tapped")
        }
        
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBAction func sellSpot(sender: UIButton) {
        
        var user = PFUser.currentUser()
        var myLotParse = PFObject(className: "MyLotParse")
//        myLotParse.setObject(self.latitude, forKey: "latitude")
//        myLotParse.setObject(self.longitude, forKey: "longitude")
        myLotParse.setObject(PFGeoPoint(latitude: self.latitude, longitude: self.longitude), forKey: "location")
        myLotParse.setObject(1, forKey: "spots")
        myLotParse.setObject(self.price.text, forKey: "price")
        myLotParse.setObject(self.notes.text, forKey: "notes")
        //myLotParse.setObject(user.username, forKey: "user")
        myLotParse.setObject(user, forKey: "owner")
        myLotParse.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if true {
                NSLog("Object created with id: \(myLotParse.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    var latitude:Double!
    var longitude:Double!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set location of satellite view
        let location = CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
      
        println(self.latitude)
        println(self.longitude)
        
        
        let barColor = UIColor(red: 247/255, green: 249/255, blue: 250/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = barColor
        
        self.navigationController?.view.layer.cornerRadius = 10.0
        
        notes.layer.cornerRadius = 5
        notes.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        notes.layer.borderWidth = 0.5
        notes.clipsToBounds = true
    }


}



/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

