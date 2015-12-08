//
//  HouseTableViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/7/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class HouseTableViewController:UITableViewController {
    
//    var allUsers = Set<User>()
    var choreListTable: ChoreListTableViewController!
    var rowOfLastChoreSelected: Int? = nil
    var tabBar: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (choreListTable == nil || choreListTable.users == nil) {
            return 0
        }
        return choreListTable.users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HouseCell", forIndexPath: indexPath)
        print("cellForRowAtIndexPath")
        let user = choreListTable.users[indexPath.row]
        cell.textLabel?.text = user!.username
        if user!.finishedChore {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rowOfLastChoreSelected = indexPath.row
        /*print("didSelectRowAtIndexPath:")
        if lastChoreSelected == nil {
        print("   nil")
        } else {
        print("   ", lastChoreSelected!.choreName)
        }*/
        print("didsselecttrowatindexpath: ", rowOfLastChoreSelected)
//        selectedAChore = true
        //        prepareForSegue(seg!, sender: seg)
//        performSegueWithIdentifier("ToChoreDetailView", sender: nil)
        
        //choresList[indexPath.row] = NSDate()
    }
    
    @IBAction func segueBackFromAddMember(segue: UIStoryboardSegue) {
        print(choreListTable.users)
        print("HUMUNA HUMUNA HUMUNA")
        
        let navForChoreTableView = tabBar.customizableViewControllers![1] as! UINavigationController
        let tableOfChores = navForChoreTableView.topViewController as! ChoreListTableViewController
        
        tableOfChores.users = choreListTable.users
        tableOfChores.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToAddHouseMember") {
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! AddHouseMemberTableViewController
            dest.choreTable = choreListTable

            dest.houseMemberTable = self
        }
    }

    
   
}
