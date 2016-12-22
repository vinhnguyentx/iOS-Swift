//
//  BarTableViewController.swift
//  HopJocky
//
//  Created by Matt Union on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase

class BarTableViewController: UITableViewController, UISearchResultsUpdating {
    var bars = [Bar]()
    var filteredBars = [Bar]()
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
//        self.resultSearchController.searchBar.scopeButtonTitles = ["Name", "Rating", "ABV", "Style"]
//        self.resultSearchController.searchBar.delegate = self
        self.tableView.reloadData()
        
        BARS_REF.observeEventType(.Value, withBlock: { snapshot in
            
            //the snapshot is a current look at our bars data
            //print(snapshot.value)
            
            self.bars = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots{
                    //make our bars array for tableview
                    if let barDict = snap.value as? Dictionary<String, AnyObject>{
                        let name = snap.key
                        let bar = Bar(key: name, dict: barDict)
                        
                        //insert new bar object into bar array
                        self.bars.append(bar)
                    }
                }
            }
            //be sure that the tableView updates when there is new data
            self.tableView.reloadData()
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active && self.resultSearchController.searchBar.text != "")
        {
            return self.filteredBars.count
        }
        else
        {
            return bars.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellid", forIndexPath: indexPath) as UITableViewCell?
        
        var bar: Bar
        if (self.resultSearchController.active && self.resultSearchController.searchBar.text != "")
        {
            bar = self.filteredBars[indexPath.row]
            cell!.textLabel?.text = bar.name
        }
        else{
            bar = self.bars[indexPath.row]
            cell!.textLabel?.text = bar.name
        }
        // Configure the cell...
        cell!.textLabel?.text = bar.name
        
//        if(self.detail == "ABV"){
//            if beer.abv == -1 {
//                cell!.detailTextLabel?.text = "Unknown"
//            }
//            else{
//                cell!.detailTextLabel?.text = String(beer.abv) + "%"
//            }
//        }
//        else if(self.detail == "Style"){
//            cell!.detailTextLabel?.text = beer.style
//        }
//        else if(self.detail == "avgRating"){
//            if beer.price == -1{
//                cell!.detailTextLabel?.text = "0"
//            }
//            else{
//                cell!.detailTextLabel?.text = String(beer.avgRating)
//            }
//        }

        return cell!
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.filteredBars.removeAll(keepCapacity:  false)
        
        for bar in bars{
            if bar.name.rangeOfString(searchController.searchBar.text!) != nil{
                filteredBars.append(bar)
            }
        }
        self.tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = self.tableView.indexPathForSelectedRow
        
        let barDetailView = segue.destinationViewController as! BarDetailViewController
        
        let barSelected: Bar
        if self.resultSearchController.active && self.resultSearchController.searchBar.text != "" {
            barSelected = filteredBars[indexPath!.row]
        } else {
            barSelected = bars[indexPath!.row]
        }
        
        
        barDetailView.barObj = barSelected
        //dismiss searcbar
        self.resultSearchController.active = false
    }


}

////for sorting
//extension BarTableViewController: UISearchBarDelegate {
//    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//        let sort = searchBar.scopeButtonTitles![selectedScope]
//        self.beers.removeAll()
//        if(sort == "Name"){
//            self.detail = "avgRating"
//            BEERS_REF.queryOrderedByChild("Name").observeEventType(.ChildAdded, withBlock: { snapshot in
//                //create beerObj out of database dict
//                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
//                    let beer = Beer(key: snapshot.key, dict: beerDict)
//                    self.beers.append(beer)
//                }
//                //if search is active order current search results
//                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
//                    self.updateSearchResultsForSearchController(self.resultSearchController)
//                }
//                self.tableView.reloadData()
//            })
//        }
//        else if(sort == "Rating"){
//            self.detail = "avgRating"
//            BEERS_REF.queryOrderedByChild("AvgRating").observeEventType(.ChildAdded, withBlock: { snapshot in
//                //create beerObj out of database dict
//                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
//                    let beer = Beer(key: snapshot.key, dict: beerDict)
//                    self.beers.insert(beer, atIndex: 0)
//                }
//                //if search is active order current search results
//                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
//                    self.updateSearchResultsForSearchController(self.resultSearchController)
//                }
//                self.tableView.reloadData()
//            })
//        }
//        else if(sort == "ABV"){
//            self.detail = "ABV"
//            BEERS_REF.queryOrderedByChild("ABV").observeEventType(.ChildAdded, withBlock: { snapshot in
//                //create beerObj out of database dict
//                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
//                    let beer = Beer(key: snapshot.key, dict: beerDict)
//                    self.beers.insert(beer, atIndex: 0)
//                }
//                //if search is active order current search results
//                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
//                    self.updateSearchResultsForSearchController(self.resultSearchController)
//                }
//                self.tableView.reloadData()
//            })
//        }
//        else if(sort == "Style"){
//            self.detail = "Style"
//            BEERS_REF.queryOrderedByChild("Style").observeEventType(.ChildAdded, withBlock: { snapshot in
//                //create beerObj out of database dict
//                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
//                    let beer = Beer(key: snapshot.key, dict: beerDict)
//                    self.beers.append(beer)
//                }
//                //if search is active order current search results
//                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
//                    self.updateSearchResultsForSearchController(self.resultSearchController)
//                }
//                self.tableView.reloadData()
//            })
//        }
//    }
//}

