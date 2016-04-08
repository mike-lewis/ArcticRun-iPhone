//
//  PartyController.swift
//  ArcticRunTemplate
//
//  Created by Ricky Chen on 3/3/16.
//  Copyright © 2016 Matt Wiseman. All rights reserved.
//

import UIKit
import Social

class CharacterViewController: UIViewController{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var nameString : String = ""
    var healthString : String = ""
    var image: UIImage = UIImage()
    var lastName: String = ""
    var memberHealth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (self.revealViewController() != nil) {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        name.text = nameString
        health.text = healthString
        imageView.image = image
        let test = getMemberHealth("Joyce")
        print(test)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets a certain party members health
    // Function returns before database query gets returns, as query is run in a seperate thread
    func getMemberHealth(partyMemberLastName: String)->Int {
        var partyMemberHealth = 0
        Member.getAllMembers { (members: [Member]) -> Void in
            for var i = 0; i < members.count; i++ {
                if (members[i].getLastName() == partyMemberLastName) {
                    partyMemberHealth = members[i].getHealth()!
                }
            }
        }
        return partyMemberHealth
    }
    
    @IBAction func TwitterShare(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func FacebookShare(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
}
