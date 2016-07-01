//
//  TweetViewController.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/28/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    var charCount : UILabel?
    var tweetEntry : UITextView?
    var postTweet : UIButton?
    var cancel : UIButton?
    var presetText : String?
    var replyID : String?
    
    var myStyle = UIStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .whiteColor()
        
        charCount = UILabel()
        if let charCount = charCount {
            charCount.text = "140"
            charCount.font = myStyle.normalFont
            charCount.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(charCount)
        }
        
        tweetEntry = UITextView()
        if let tweetEntry = tweetEntry {
            tweetEntry.layer.borderWidth = 1
            tweetEntry.layer.borderColor = UIColor.lightGrayColor().CGColor
            tweetEntry.layer.cornerRadius = 5
            tweetEntry.font = myStyle.normalFont
            tweetEntry.layer.masksToBounds = true
            
            tweetEntry.delegate = self
            
            if let presetText = presetText {
                tweetEntry.text = presetText
            }
            tweetEntry.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(tweetEntry)
        }
        
        postTweet = UIButton()
        if let postTweet = postTweet {
            postTweet.translatesAutoresizingMaskIntoConstraints = false
            postTweet.setTitle("Tweet!", forState: .Normal)
            postTweet.setTitleColor(.blueColor(), forState: .Normal)
            self.view.addSubview(postTweet)
            postTweet.addTarget(self, action: #selector(makeTweet(_:)), forControlEvents: .TouchUpInside)
        }
        
        cancel = UIButton()
        if let cancel = cancel {
            cancel.translatesAutoresizingMaskIntoConstraints = false
            cancel.setTitle("Cancel", forState: .Normal)
            cancel.setTitleColor(.blackColor(), forState: .Normal)
            self.view.addSubview(cancel)
            cancel.addTarget(self, action: #selector(cancelEditor(_:)), forControlEvents: .TouchUpInside)
        }
        
        //Character Count Box
        
        NSLayoutConstraint(item: charCount!,
                           attribute: .Leading,
                           relatedBy: .GreaterThanOrEqual,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: charCount!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: charCount!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self.topLayoutGuide,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: charCount!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tweetEntry,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        
        //Tweet Entry Box
        
        NSLayoutConstraint(item: tweetEntry!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweetEntry!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweetEntry!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: charCount,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweetEntry!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: postTweet,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -20.0).active = true

        //Post Tweet Button

        NSLayoutConstraint(item: postTweet!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: cancel,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: postTweet!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: postTweet!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetEntry,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: postTweet!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self.bottomLayoutGuide,
                           attribute: .Top,
                           multiplier: 0.5,
                           constant: 0.0).active = true
        
        //Cancel
        
        NSLayoutConstraint(item: cancel!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: cancel!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: postTweet,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: cancel!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetEntry,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: cancel!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self.bottomLayoutGuide,
                           attribute: .Top,
                           multiplier: 0.5,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: cancel!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: postTweet,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        var str = textView.text as String
        if str.characters.count > 140 {
            let index = str.startIndex.advancedBy(139)
            str = String(str.characters.prefixThrough(index))
            textView.text = str
        }
        charCount!.text = "\(140 - str.characters.count)"
    }
    
    func makeTweet(sender : AnyObject?) {
        let status = tweetEntry!.text
        if status != "" {
            APICall.sendTweet(status, reply: replyID)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func cancelEditor(sender : AnyObject?) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
