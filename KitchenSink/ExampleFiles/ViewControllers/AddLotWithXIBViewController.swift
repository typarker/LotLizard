//
//  AddLotWithXIBViewController.swift
//  LotLizard
//
//  Created by Ty Parker on 1/23/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit

class AddLotWithXIBViewController: UIViewController, PFLogInViewControllerDelegate {
    
    @IBOutlet weak var blah: UILabel!
    
//    @IBOutlet weak var colorLabel: UILabel!
//    @IBOutlet weak var price: UITextField!
//    
//    @IBOutlet weak var label: UILabel!
//    @IBAction func sellSpot(sender: UIButton) {
//        
//        var user = PFUser.currentUser()
//        var myLotParse = PFObject(className: "MyLotParse")
//        myLotParse.setObject(self.latitude, forKey: "latitude")
//        myLotParse.setObject(self.longitude, forKey: "longitude")
//        myLotParse.setObject(1, forKey: "spots")
//        myLotParse.setObject(self.price.text, forKey: "price")
//        //myLotParse.setObject(user.username, forKey: "user")
//        myLotParse.setObject(user, forKey: "owner")
//        myLotParse.saveInBackgroundWithBlock {
//            (success: Bool!, error: NSError!) -> Void in
//            if true {
//                NSLog("Object created with id: \(myLotParse.objectId)")
//            } else {
//                NSLog("%@", error)
//            }
//        }
//        
//    }
//    
//    var latitude:Double!
//    var longitude:Double!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blah.text = "Label"
        
        // Do any additional setup after loading the view.
        //colorLabel.text = latitude
//        println(self.latitude)
//        println(self.longitude)
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

