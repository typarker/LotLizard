//
//  LeftNavigationViewController.swift

//
//  TableViewController.swift
//  StaticCellsSwift
//
//  Created by Brian Mancini on 9/28/14.
//  Copyright (c) 2014 iOSExamples. All rights reserved.
//

import Foundation
import UIKit

class Left: UITableViewController {
    
    
    var buySpotCell: UITableViewCell = UITableViewCell()
    var sellSpotCell: UITableViewCell = UITableViewCell()
    var viewAccountCell: UITableViewCell = UITableViewCell()
    var shareCell: UITableViewCell = UITableViewCell()
    
    
    
    
    var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var button2   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var button3   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        var center = BuySpotViewController()
        let nav = UINavigationController(rootViewController: center)
        
        
            //self.evo_drawerController?.setCenterViewController(nav, withCloseAnimation: true, completion: nil)
        
            self.evo_drawerController?.setCenterViewController(nav, withFullCloseAnimation: true, completion: nil)
        
    }
    
    func sellSpot(sender:UIButton!)
    {
        println("Button tapped")
        var center = SellSpotViewController()
        let nav = UINavigationController(rootViewController: center)
        
        
        //self.evo_drawerController?.setCenterViewController(nav, withCloseAnimation: true, completion: nil)
        
        self.evo_drawerController?.setCenterViewController(nav, withFullCloseAnimation: true, completion: nil)
        
    }
    
    func viewAccount(sender:UIButton!)
    {
        println("Button tapped")
        var center = AccountViewController()
        let nav = UINavigationController(rootViewController: center)
        
        
        //self.evo_drawerController?.setCenterViewController(nav, withCloseAnimation: true, completion: nil)
        
        self.evo_drawerController?.setCenterViewController(nav, withFullCloseAnimation: true, completion: nil)
        
    }
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "User Options"
        
//        // construct first name cell, section 0, row 0
//        self.buySpotCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
//        self.firstNameText = UITextField(frame: CGRectInset(self.buySpotCell.contentView.bounds, 15, 0))
//        self.firstNameText.placeholder = "First Name"
//        self.buySpotCell.addSubview(self.firstNameText)
        

        button.frame = CGRectInset(self.buySpotCell.contentView.bounds, 15 ,0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button.setTitle("Reserve Parking Spot", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.buySpotCell.addSubview(button)
        
        // construct first name cell, section 0, row 0
//        self.buySpotCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
//        self.firstNameText = UIButton(frame: CGRectInset(self.buySpotCell.contentView.bounds, 15, 0))
//        self.firstNameText.titleLabel?.text = "First Name"
//        self.buySpotCell.addSubview(self.firstNameText)
        
        button2.frame = CGRectInset(self.buySpotCell.contentView.bounds, 15 ,0)
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button2.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button2.setTitle("Sell Parking Spot", forState: UIControlState.Normal)
        button2.addTarget(self, action: "sellSpot:", forControlEvents: UIControlEvents.TouchUpInside)
        self.sellSpotCell.addSubview(button2)
        
        button3.frame = CGRectInset(self.buySpotCell.contentView.bounds, 15 ,0)
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button3.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button3.setTitle("Your Account", forState: UIControlState.Normal)
        button3.addTarget(self, action: "viewAccount:", forControlEvents: UIControlEvents.TouchUpInside)
        self.viewAccountCell.addSubview(button3)
        
        // construct share cell, section 1, row 0
        self.shareCell.textLabel?.text = "Share with Friends"
        self.shareCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.shareCell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3    // section 0 has 2 rows
        //case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.buySpotCell   // section 0, row 0 is the first name
            case 1: return self.sellSpotCell    // section 0, row 1 is the last name
            case 2: return self.viewAccountCell
            default: fatalError("Unknown row in section 0")
            }
//        case 1:
//            switch(indexPath.row) {
//            case 0: return self.shareCell       // section 1, row 0 is the share option
//            default: fatalError("Unknown row in section 1")
//            }
        default: fatalError("Unknown section")
        }
    }
    
//    // Customize the section headings for each section
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch(section) {
//        case 0: return "Menu"
//        case 1: return "Social"
//        default: fatalError("Unknown section")
//        }
//    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Handle social cell selection to toggle checkmark
        if(indexPath.section == 1 && indexPath.row == 0) {
            
            // deselect row
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
            // toggle check mark
            if(self.shareCell.accessoryType == UITableViewCellAccessoryType.None) {
                self.shareCell.accessoryType = UITableViewCellAccessoryType.Checkmark;
            } else {
                self.shareCell.accessoryType = UITableViewCellAccessoryType.None;
            }
        }
    }
    
}