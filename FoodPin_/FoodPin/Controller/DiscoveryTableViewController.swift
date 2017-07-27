//
//  DiscoveryTableViewController.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/22.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class DiscoveryTableViewController: UITableViewController {

    var restaurants:[RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = 250
        navigationController?.hidesBarsOnSwipe = true

        DispatchQueue.global().async {
            
            self.loadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    func loadData() {
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor (key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let app = (UIApplication.shared.delegate as? AppDelegate) {
            let context = app.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController (fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DiscoveryTableViewCell

        // Configure the cell...
        
        let restaurantMO = restaurants[indexPath.row]
        
        cell.configCellDataWithRestaurantMO(restaurantMO: restaurantMO)
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
