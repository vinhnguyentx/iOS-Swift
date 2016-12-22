//
//  PopoverVoteViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class PopoverVoteViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var voteViewController:VoteViewController? = nil
    var showVotesViewController:ShowVotesViewController? = nil
    
    private var dataModel:DataModel = DataModel()
    
    convenience init(data:DataModel) {
        self.init()
        self.dataModel = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentVotePopover(sourceController sourceController:UIViewController, sourceView:UIView, sourceRect:CGRect) {
        
        self.voteViewController = VoteViewController(title: "Vote", data: dataModel, preferredContentSize: CGSize(width: 300, height: 200))
        
        // Cause the views to be created in this view controller. Gets them added to the view hierarchy.
        self.voteViewController?.view
        self.voteViewController?.tableView.layoutIfNeeded()
        
        // Set attributes for the popover controller.
        // Notice we're get an existing object from the view controller we want to popup!
        let popoverMenuViewController = self.voteViewController!.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sourceView
        popoverMenuViewController?.sourceRect = sourceRect
        
        // Show the popup.
        // Notice we are presenting form a view controller passed in. We need to present from a view controller
        // that has views that are already in the view hierarchy.
        sourceController.presentViewController(self.voteViewController!, animated: true, completion: nil)
    }
    
    func presentShowVotesPopover(sourceController sourceController:UIViewController, sourceView:UIView, sourceRect:CGRect) {
        
        self.showVotesViewController = ShowVotesViewController(title: "Vote", data: dataModel, preferredContentSize: CGSize(width: 300, height: 200))
        
        // Cause the views to be created in this view controller. Gets them added to the view hierarchy.
        self.showVotesViewController?.view
        self.showVotesViewController?.tableView.layoutIfNeeded()
        
        // Set attributes for the popover controller.
        // Notice we're get an existing object from the view controller we want to popup!
        let popoverMenuViewController = self.showVotesViewController!.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sourceView
        popoverMenuViewController?.sourceRect = sourceRect
        
        // Show the popup.
        // Notice we are presenting form a view controller passed in. We need to present from a view controller
        // that has views that are already in the view hierarchy.
        sourceController.presentViewController(self.showVotesViewController!, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Indicate we want the same presentation behavior on both iPhone and iPad.
        return .None
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
