//
//  RMRoserViewController.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/29.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit


class RMRoserViewController: UITableViewController,NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFriend()
        
          }
    
    var resultController:NSFetchedResultsController!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func loadFriend() {
        
        let context = RMXMPPManager.getSharedInstach().xmppRoserStore.mainThreadManagedObjectContext
        let request = NSFetchRequest(entityName:"XMPPUserCoreDataStorageObject")
        let jidStr  = RMUser.getSharedInstace().userName! + "@" + XMPPDOMAIN
        let predicate = NSPredicate(format: "streamBareJidStr = %@", jidStr)
        request.predicate = predicate
        let sortData = NSSortDescriptor(key: "displayName", ascending: true)
        request.sortDescriptors = [sortData]
        resultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        resultController.delegate = self
        do {
            
            try resultController .performFetch()

        } catch {
            
            print("错误")
        }
        
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (resultController.fetchedObjects?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let roser:XMPPUserCoreDataStorageObject = resultController.fetchedObjects![indexPath.row] as! XMPPUserCoreDataStorageObject
        cell?.textLabel?.text = roser.jidStr
        
        return cell!
  }
   
}
