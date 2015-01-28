//
//  PurchaseSpotViewController.swift
//  LotLizard
//
//  Created by Ty Parker on 1/25/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

//
//  AddLotWithXIBViewController.swift
//  LotLizard
//
//  Created by Ty Parker on 1/23/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit
import MapKit

class PurchaseSpotViewController: UIViewController, PFLogInViewControllerDelegate, MKMapViewDelegate {
    
    
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
        

        
                
                //send push to seller
                let message: NSString = "Some Dude Bought Your Spot"
                
                var data = [ "title": "Some Title",
                    "alert": message]
                let owner = ann.owner
                
                var installQuery = PFQuery(className: "Installation")
                installQuery.whereKey("user" , equalTo: owner)
                //var installation = installQuery.getFirstObject()
                //var installId = installation.objectForKey("installationId") as? String
                
                var push: PFPush = PFPush()
                push.setQuery(installQuery)
                push.setData(data)
                push.sendPushInBackground()
                
                
                
                //var query: PFQuery = PFInstallation.query()
                
                //remove a spot
        var query = PFQuery(className:"MyLotParse")
        query.getObjectInBackgroundWithId(ann.id) {
            (myLotParse: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            }
            else {
                myLotParse.incrementKey("spots", byAmount: -1)
                myLotParse.saveInBackground()
            }

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    }
    
    
    var latitude:Double!
    var longitude:Double!
    var ann:LotAnnotation!
    
    
    
    
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
        price.text = ann.title
        notes.text = ann.notes
        
        
        
        
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