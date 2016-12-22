//
//  BeersTableViewController.swift
//  HopJocky
//
//  Created by Matt Union on 4/26/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase

class BeersTableViewController: UITableViewController, UISearchResultsUpdating {
    var beers = [Beer]()
    var filteredBeers = [Beer]()
    var resultSearchController = UISearchController()
    var detail = "avgRating"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.resultSearchController.searchBar.scopeButtonTitles = ["Name", "Rating", "ABV", "Style"]
        self.resultSearchController.searchBar.delegate = self
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        BEERS_REF.observeEventType(.Value, withBlock: { snapshot in
            
            self.beers = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots{
                    //make our bars array for tableview
                    if let beerDict = snap.value as? Dictionary<String, AnyObject>{
                        let name = snap.key
                        let beer = Beer(key: name, dict: beerDict)
                        //insert new beer object into beers array
                        self.beers.append(beer)
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
    
    @IBAction func NameOrderButton(sender: AnyObject) {
        self.beers.removeAll()
        self.detail = "avgRating"
        BEERS_REF.queryOrderedByChild("Name").observeEventType(.ChildAdded, withBlock: { snapshot in
            //create beerObj out of database dict
            if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                let beer = Beer(key: snapshot.key, dict: beerDict)
                self.beers.append(beer)
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func PriceOrderButton(sender: AnyObject) {
        self.beers.removeAll()
        self.detail = "avgRating"
        BEERS_REF.queryOrderedByChild("AvgRating").observeEventType(.ChildAdded, withBlock: { snapshot in
            //create beerObj out of database dict
            if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                let beer = Beer(key: snapshot.key, dict: beerDict)
                self.beers.insert(beer, atIndex: 0)
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func ABVOrderButton(sender: AnyObject) {
        self.beers.removeAll()
        self.detail = "ABV"
        BEERS_REF.queryOrderedByChild("ABV").observeEventType(.ChildAdded, withBlock: { snapshot in
            //create beerObj out of database dict
            if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                let beer = Beer(key: snapshot.key, dict: beerDict)
                self.beers.insert(beer, atIndex: 0)
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func StyleOrderButton(sender: AnyObject) {
        self.beers.removeAll()
        self.detail = "Style"
        BEERS_REF.queryOrderedByChild("Style").observeEventType(.ChildAdded, withBlock: { snapshot in
            //create beerObj out of database dict
            if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                let beer = Beer(key: snapshot.key, dict: beerDict)
                self.beers.append(beer)
            }
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active && self.resultSearchController.searchBar.text != "")
        {
            return self.filteredBeers.count
        }
        else
        {
            return beers.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("beerCell", forIndexPath: indexPath) as UITableViewCell?
        
        var beer: Beer
        if (self.resultSearchController.active && self.resultSearchController.searchBar.text != "")
        {
            beer = self.filteredBeers[indexPath.row]
            cell!.textLabel?.text = beer.name
        }
        else{
            beer = self.beers[indexPath.row]
            cell!.textLabel?.text = beer.name
        }
        // Configure the cell...
        cell!.textLabel?.text = beer.name
        
        if(self.detail == "ABV"){
            if beer.abv == -1 {
                cell!.detailTextLabel?.text = "Unknown"
            }
            else{
                cell!.detailTextLabel?.text = String(beer.abv) + "%"
            }
        }
        else if(self.detail == "Style"){
            cell!.detailTextLabel?.text = beer.style
        }
        else if(self.detail == "avgRating"){
            if beer.price == -1{
                cell!.detailTextLabel?.text = "0"
            }
            else{
                cell!.detailTextLabel?.text = String(beer.avgRating)
            }
        }
        return cell!
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.filteredBeers.removeAll(keepCapacity:  false)
        
        for beer in beers{
            if beer.name.rangeOfString(searchController.searchBar.text!) != nil{
                filteredBeers.append(beer)
            }
        }
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        let beersDetailView = segue.destinationViewController as! BeersDetailViewController
        
        let beerSelected: Beer
        if self.resultSearchController.active && self.resultSearchController.searchBar.text != "" {
            beerSelected = filteredBeers[indexPath!.row]
        } else {
            beerSelected = beers[indexPath!.row]
        }
        
        
        beersDetailView.beerObj = beerSelected
        //dismiss searcbar
        self.resultSearchController.active = false
    }
    
    
}

//for sorting
extension BeersTableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        let sort = searchBar.scopeButtonTitles![selectedScope]
        self.beers.removeAll()
        if(sort == "Name"){
            self.detail = "avgRating"
            BEERS_REF.queryOrderedByChild("Name").observeEventType(.ChildAdded, withBlock: { snapshot in
                //create beerObj out of database dict
                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                    let beer = Beer(key: snapshot.key, dict: beerDict)
                    self.beers.append(beer)
                }
                //if search is active order current search results
                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
                        self.updateSearchResultsForSearchController(self.resultSearchController)
                }
                self.tableView.reloadData()
            })
        }
        else if(sort == "Rating"){
            self.detail = "avgRating"
            BEERS_REF.queryOrderedByChild("AvgRating").observeEventType(.ChildAdded, withBlock: { snapshot in
                //create beerObj out of database dict
                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                    let beer = Beer(key: snapshot.key, dict: beerDict)
                    self.beers.insert(beer, atIndex: 0)
                }
                //if search is active order current search results
                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
                    self.updateSearchResultsForSearchController(self.resultSearchController)
                }
                self.tableView.reloadData()
            })
        }
        else if(sort == "ABV"){
            self.detail = "ABV"
            BEERS_REF.queryOrderedByChild("ABV").observeEventType(.ChildAdded, withBlock: { snapshot in
                //create beerObj out of database dict
                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                    let beer = Beer(key: snapshot.key, dict: beerDict)
                    self.beers.insert(beer, atIndex: 0)
                }
                //if search is active order current search results
                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
                    self.updateSearchResultsForSearchController(self.resultSearchController)
                }
                self.tableView.reloadData()
            })
        }
        else if(sort == "Style"){
            self.detail = "Style"
            BEERS_REF.queryOrderedByChild("Style").observeEventType(.ChildAdded, withBlock: { snapshot in
                //create beerObj out of database dict
                if let beerDict = snapshot.value as? Dictionary<String,AnyObject>{
                    let beer = Beer(key: snapshot.key, dict: beerDict)
                    self.beers.append(beer)
                }
                //if search is active order current search results
                if(self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
                    self.updateSearchResultsForSearchController(self.resultSearchController)
                }
                self.tableView.reloadData()
            })
        }
    }
}