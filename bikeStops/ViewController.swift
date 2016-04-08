//
//  ViewController.swift
//  bikeStops
//
//  Created by James Rochabrun on 08-04-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var bikeStops = [NSDictionary]()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        

        let url = NSURL(string: "http://www.bayareabikeshare.com/stations/json")
        let session = NSURLSession.sharedSession()
        //
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            do {
                self.bikeStops = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)["stationBeanList"] as! [NSDictionary]!
                
                //need to refresh data after finish loading, puts this back in the main queue
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
//                    print(self.bikeStops)
                })
            }catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }
        
        //actually runs task. followed by block(aka do...) after task is finished
        task.resume()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bikeStops.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let bikeStop = self.bikeStops[indexPath.row]
        
        cell.textLabel!.text = bikeStop["stationName"] as? String
        
        cell.detailTextLabel!.text = bikeStop["availableBikes"] as? String
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let bikeStop = self.bikeStops[indexPath!.row]
        
        let destVC = segue.destinationViewController as! MapViewController
        
        destVC.bikeStop = bikeStop
        
        
    }
    
    
    
    
    
    
}





















