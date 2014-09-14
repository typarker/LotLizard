//
//  ExampleSideDrawerViewController.swift
//  DrawerControllerKitchenSink
//
//  Created by Sascha Schwabbauer on 14.09.14.
//  Copyright (c) 2014 evolved.io. All rights reserved.
//

import UIKit

enum DrawerSection: Int {
    case ViewSelection
    case DrawerWidth
    case ShadowToggle
    case OpenDrawerGestures
    case CloseDrawerGestures
    case CenterHiddenInteraction
    case StretchDrawer
    case AlwaysShowDrawerInRegularHorizontalSizeClass
}

class ExampleSideDrawerViewController: ExampleViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    let drawerWidths: [CGFloat] = [160, 200, 240, 280, 320]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        
        self.tableView.backgroundColor = UIColor(red: 110 / 255, green: 113 / 255, blue: 115 / 255, alpha: 1.0)
        self.tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 161 / 255, green: 164 / 255, blue: 166 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 55 / 255, green: 70 / 255, blue: 77 / 255, alpha: 1.0)]
        
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections() - 1)), withRowAnimation: .None)
    }
    
    override func contentSizeDidChange(size: String) {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case DrawerSection.ViewSelection.toRaw():
            return 2
        case DrawerSection.DrawerWidth.toRaw():
            return self.drawerWidths.count
        case DrawerSection.ShadowToggle.toRaw():
            return 1
        case DrawerSection.OpenDrawerGestures.toRaw():
            return 3
        case DrawerSection.CloseDrawerGestures.toRaw():
            return 6
        case DrawerSection.CenterHiddenInteraction.toRaw():
            return 3
        case DrawerSection.StretchDrawer.toRaw():
            return 1
        case DrawerSection.AlwaysShowDrawerInRegularHorizontalSizeClass.toRaw():
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = SideDrawerTableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
            cell.selectionStyle = .Blue
        }
        
        switch indexPath.section {
        case DrawerSection.ViewSelection.toRaw():
            if indexPath.row == 0 {
                cell.textLabel?.text = "Quick View Change"
            } else {
                cell.textLabel?.text = "Full View Change"
            }
            
            cell.accessoryType = .DisclosureIndicator
        case DrawerSection.DrawerWidth.toRaw():
            // Implement in Subclass
            break
        case DrawerSection.ShadowToggle.toRaw():
            cell.textLabel?.text = "Show Shadow"
            
            if self.evo_drawerController != nil && self.evo_drawerController!.showsShadows {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        case DrawerSection.OpenDrawerGestures.toRaw():
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Pan Nav Bar"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.openDrawerGestureModeMask & .PanningNavigationBar).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 1:
                cell.textLabel?.text = "Pan Center View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.openDrawerGestureModeMask & .PanningCenterView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 2:
                cell.textLabel?.text = "Bezel Pan Center View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.openDrawerGestureModeMask & .BezelPanningCenterView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            default:
                break
            }
        case DrawerSection.CloseDrawerGestures.toRaw():
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Pan Nav Bar"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .PanningNavigationBar).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 1:
                cell.textLabel?.text = "Pan Center View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .PanningCenterView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 2:
                cell.textLabel?.text = "Bezel Pan Center View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .BezelPanningCenterView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 3:
                cell.textLabel?.text = "Tap Nav Bar"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .TapNavigationBar).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 4:
                cell.textLabel?.text = "Tap Center View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .TapCenterView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 5:
                cell.textLabel?.text = "Pan Drawer View"
                
                if self.evo_drawerController != nil && (self.evo_drawerController!.closeDrawerGestureModeMask & .PanningDrawerView).toRaw() > 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            default:
                break
            }
        case DrawerSection.CenterHiddenInteraction.toRaw():
            cell.selectionStyle = .Blue
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "None"
                
                if self.evo_drawerController != nil && self.evo_drawerController!.centerHiddenInteractionMode == .None {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 1:
                cell.textLabel?.text = "Full"
                
                if self.evo_drawerController != nil && self.evo_drawerController!.centerHiddenInteractionMode == .Full {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            case 2:
                cell.textLabel?.text = "Nav Bar Only"
                
                if self.evo_drawerController != nil && self.evo_drawerController!.centerHiddenInteractionMode == .NavigationBarOnly {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            default:
                break
            }
        case DrawerSection.StretchDrawer.toRaw():
            cell.textLabel?.text = "Stretch Drawer"
            
            if self.evo_drawerController != nil && self.evo_drawerController!.shouldStretchDrawer {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        case DrawerSection.AlwaysShowDrawerInRegularHorizontalSizeClass.toRaw():
            // Implement in Subclass
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case DrawerSection.ViewSelection.toRaw():
            return "New Center View"
        case DrawerSection.DrawerWidth.toRaw():
            return "Drawer Width"
        case DrawerSection.ShadowToggle.toRaw():
            return "Shadow"
        case DrawerSection.OpenDrawerGestures.toRaw():
            return "Drawer Open Gestures"
        case DrawerSection.CloseDrawerGestures.toRaw():
            return "Drawer Close Gestures"
        case DrawerSection.CenterHiddenInteraction.toRaw():
            return "Open Center Interaction Mode"
        case DrawerSection.StretchDrawer.toRaw():
            return "Stretch Drawer"
        case DrawerSection.AlwaysShowDrawerInRegularHorizontalSizeClass.toRaw():
            return "Regular Horizontal Size Class"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SideDrawerSectionHeaderView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(tableView.bounds), height: 56.0))
        headerView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        headerView.title = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case DrawerSection.ViewSelection.toRaw():
            let center = ExampleCenterTableViewController()
            let nav = NavigationController(rootViewController: center)
            
            if indexPath.row % 2 == 0 {
                self.evo_drawerController?.setCenterViewController(nav, withCloseAnimation: true, completion: nil)
            } else {
                self.evo_drawerController?.setCenterViewController(nav, withFullCloseAnimation: true, completion: nil)
            }
        case DrawerSection.DrawerWidth.toRaw():
            // Implement in Subclass
            break
        case DrawerSection.ShadowToggle.toRaw():
            self.evo_drawerController?.showsShadows = !self.evo_drawerController!.showsShadows
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
        case DrawerSection.OpenDrawerGestures.toRaw():
            switch indexPath.row {
            case 0:
                self.evo_drawerController?.openDrawerGestureModeMask ^= .PanningNavigationBar
            case 1:
                self.evo_drawerController?.openDrawerGestureModeMask ^= .PanningCenterView
            case 2:
                self.evo_drawerController?.openDrawerGestureModeMask ^= .BezelPanningCenterView
            default:
                break
            }
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        case DrawerSection.CloseDrawerGestures.toRaw():
            switch indexPath.row {
            case 0:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .PanningNavigationBar
            case 1:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .PanningCenterView
            case 2:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .BezelPanningCenterView
            case 3:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .TapNavigationBar
            case 4:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .TapCenterView
            case 5:
                self.evo_drawerController?.closeDrawerGestureModeMask ^= .PanningDrawerView
            default:
                break
            }
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        case DrawerSection.CenterHiddenInteraction.toRaw():
            self.evo_drawerController?.centerHiddenInteractionMode = DrawerOpenCenterInteractionMode.fromRaw(indexPath.row)!
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
        case DrawerSection.StretchDrawer.toRaw():
            self.evo_drawerController?.shouldStretchDrawer = !self.evo_drawerController!.shouldStretchDrawer
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        case DrawerSection.AlwaysShowDrawerInRegularHorizontalSizeClass.toRaw():
            // Implement in Subclass
            break
        default:
            break
        }
        
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}