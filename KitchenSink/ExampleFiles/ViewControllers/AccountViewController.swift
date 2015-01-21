//
//  AccountViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Ty Parker on 1/20/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

//
//  BuySpotViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Ty Parker on 1/15/15.
//  Copyright (c) 2015 evolved.io. All rights reserved.
//

import UIKit




class AccountViewController: UITableViewController, UITableViewDelegate, PFLogInViewControllerDelegate {
    
    var userCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "userCell")
    var logOutCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "logOutCell")
    
    
    var logOut = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Your Account"
        // construct first name cell, section 0, row 0
//        self.buySpotCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
//        self.firstNameText = UITextField(frame: CGRectInset(self.buySpotCell.contentView.bounds, 15, 0))
//        self.firstNameText.placeholder = "First Name"
//        self.buySpotCell.addSubview(self.firstNameText)
        
        logOut.frame = CGRectInset(self.logOutCell.contentView.bounds, 15 ,0)
        logOut.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        logOut.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
        
       
        
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
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2
        //case 1: return 1
        default: fatalError("Unknown number of sections")
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> 
        UITableViewCell {
            
            switch(indexPath.section) {
            case 0:
                switch(indexPath.row) {
                case 0: if PFUser.currentUser() != nil { self.userCell.textLabel!.text = "Logged in as " + PFUser.currentUser().username}
                else {self.userCell.textLabel?.text = "Not logged in"}
                    return self.userCell  // section 0, row 0 is the first name
                case 1:
                    if PFUser.currentUser() != nil {
                        logOut.setTitle("Log Out", forState: UIControlState.Normal)
                        logOut.addTarget(self, action: "logOut:", forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    else{
                        logOut.setTitle("Log In", forState: UIControlState.Normal)
                        logOut.addTarget(self, action: "logIn:", forControlEvents: UIControlEvents.TouchUpInside)
                    }
                        self.logOutCell.addSubview(logOut)
                        return self.logOutCell    // section 0, row 1 is the last name
                //case 2: return self.logOutCell
                default: fatalError("Unknown row in section 0")
                }
            case 1:
                switch(indexPath.row) {
                case 0: return self.userCell      // section 1, row 0 is the share option
                default: fatalError("Unknown row in section 1")
                }
            default: fatalError("Unknown section")
            }
    
    // Configure the cell...
 
    }
    
    func logOut(sender:UIButton!)
    {
           // Log Out User
        PFUser.logOut()
        self.tableView.reloadData()
        
//        // Show the signup or login screen
//        var logInController = PFLogInViewController()
//        var signUpController = PFSignUpViewController()
//        
//        //let users sign up with email only
//        
//        
//        //        logInController.signUpController = signUpController
//        //
//        //        logInController.signUpController.delegate = self
//        logInController.delegate = self
//        //        logInController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten
//        //
//        //        logInController.signUpController.fields = PFSignUpFields.UsernameAndPassword
//        //            | PFSignUpFields.SignUpButton
//        //            | PFSignUpFields.DismissButton
//        self.presentViewController(logInController, animated:true, completion: nil)
//        //self.presentViewController(signUpController, animated:true, completion: nil)
        
        
    
    }
    
    func logIn(sender:UIButton!){
        // Show the signup or login screen
        var logInController = PFLogInViewController()
        logInController.delegate = self
        logInController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
        self.presentViewController(logInController, animated:true, completion: nil)
        self.tableView.reloadData()
    }
    //Dismiss Login View Controller after Login
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.tableView.reloadData()
        
        //matching user to device
        let currentInstallation: PFInstallation = PFInstallation.currentInstallation()
        var user = PFUser.currentUser()
        currentInstallation.setObject(user, forKey: "user")
        currentInstallation.saveInBackground()
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    

    
    
    
    
    
    
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