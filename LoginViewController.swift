//
//  LoginViewController.swift
//  
//
//  Created by Jeanne Luning Prak on 6/27/16.
//
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    var button : UIButton?
    var style = UIStyle()
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        self.view.backgroundColor = .whiteColor()
        
        button = UIButton()
        
        if let button = button {
            button.setTitle("Sign In With Twitter", forState: .Normal)
            button.backgroundColor = style.twitterColor
            button.setTitleColor(.whiteColor(), forState: .Normal)
            button.addTarget(self, action: #selector(loginOAuth), forControlEvents: UIControlEvents.TouchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(button)
            
            NSLayoutConstraint(item: button,
                               attribute: .Leading,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .LeadingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: button,
                               attribute: .Trailing,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .TrailingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true

            NSLayoutConstraint(item: button,
                               attribute: .CenterY,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .CenterY,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: button,
                               attribute: .Height,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .Height,
                               multiplier: 0.1,
                               constant: 0.0).active = true

            
        }

        // Do any additional setup after loading the view.
    }
    
    func loginOAuth(sender: UIButton) {
        APICall.loginOAuth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
