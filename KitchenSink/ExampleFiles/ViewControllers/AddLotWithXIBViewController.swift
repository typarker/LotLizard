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
    
    @IBOutlet weak var blah: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBAction func sellSpot(sender: UIButton) {
        
        var user = PFUser.currentUser()
        var myLotParse = PFObject(className: "MyLotParse")
        myLotParse.setObject(self.latitude, forKey: "latitude")
        myLotParse.setObject(self.longitude, forKey: "longitude")
        myLotParse.setObject(1, forKey: "spots")
        myLotParse.setObject(self.price.text, forKey: "price")
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
        
    }
    
    var latitude:Double!
    var longitude:Double!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.mapView = MKMapView()
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
        // 2
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        //self.mapView.mapType = .Standard
        //self.mapView.frame = view.frame
        //self.mapView.delegate = self
        //self.view.addSubview(self.mapView)
        
        self.blah.text = "Label"
        
        // Do any additional setup after loading the view.
        //colorLabel.text = latitude
        println(self.latitude)
        println(self.longitude)
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

