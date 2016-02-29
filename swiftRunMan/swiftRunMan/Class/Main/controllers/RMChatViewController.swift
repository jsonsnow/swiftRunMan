//
//  RMChatViewController.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/29.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit

class RMChatViewController: UITableViewController ,NSFetchedResultsControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadChatMessage()
        
    }
    var friendJid:XMPPJID?
    var resultController:NSFetchedResultsController!
    
    func loadChatMessage() {
        
        let context = RMXMPPManager.getSharedInstach().xmppMessageStore.mainThreadManagedObjectContext

        let request = NSFetchRequest(entityName: "XMPPMessageArchiving_Message_CoreDataObject")
        let jidStr  = RMUser.getSharedInstace().userName! + "@" + XMPPDOMAIN
        let friendStr = self.friendJid?.bare()
        let predicate = NSPredicate(format: "bareJidStr=%@ and streamBareJidStr=%@", jidStr,friendStr!)
        request.predicate = predicate
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        request.sortDescriptors = [sort]
        self.resultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.resultController?.delegate = self
        do {
            
            
            try resultController.performFetch()
            
        } catch {
            
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.resultController.fetchedObjects?.count)!
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier")
        }
        let message = self.resultController.fetchedObjects![indexPath.row]
        cell!.textLabel?.text = message.body()
        cell!.detailTextLabel?.text = message.bareJidStr
        // Configure the cell...

        return cell!
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            segue.destinationViewController
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
