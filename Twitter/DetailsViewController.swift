//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/28/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweet : Tweet?
    var tweetText : UILabel?
    var profilePic : UIImageView?
    var userName : UILabel?
    var timeStamp : UILabel?
    var favorite : UIButton?
    var retweet : UIButton?
    var tableView : UITableView?
    
    var myStyle = UIStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .whiteColor()
        
        makeTableView()
        setUpTweetFeatures()
        layout()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpTweetFeatures() {
        tweetText = UILabel()
        if let tweetText = tweetText {
            tweetText.numberOfLines = 0
            tweetText.lineBreakMode = .ByWordWrapping
            tweetText.font = myStyle.normalFont
            
            tweetText.backgroundColor = .whiteColor()
            view.addSubview(tweetText)
            
            tweetText.translatesAutoresizingMaskIntoConstraints = false
        }
        profilePic = UIImageView()
        if let profilePic = profilePic {
            view.addSubview(profilePic)
            
            profilePic.translatesAutoresizingMaskIntoConstraints = false
        }
        userName = UILabel()
        if let userName = userName {
            view.addSubview(userName)
            userName.font = myStyle.boldFont
            
            userName.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeStamp = UILabel()
        if let timeStamp = timeStamp {
            view.addSubview(timeStamp)
            timeStamp.font = myStyle.normalFont
            timeStamp.textColor = .grayColor()
            timeStamp.translatesAutoresizingMaskIntoConstraints = false
        }
        
        favorite = UIButton()
        if let favorite = favorite {
            view.addSubview(favorite)
            favorite.setTitleColor(.blackColor() , forState: .Normal)
            favorite.titleLabel!.font = myStyle.normalFont
            favorite.titleLabel!.textAlignment = .Left
            favorite.setTitle("<3", forState: .Normal)
            favorite.translatesAutoresizingMaskIntoConstraints = false
        }
        
        retweet = UIButton()
        if let retweet = retweet {
            view.addSubview(retweet)
            retweet.setTitleColor(.blackColor() , forState: .Normal)
            retweet.titleLabel!.font = myStyle.normalFont
            retweet.titleLabel!.textAlignment = .Left
            retweet.setTitle("RT", forState: .Normal)
            retweet.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if let tweet = tweet {
            makeUI(tweet)
        }

    }
    
    func layout() {
        //Text of Tweet
        NSLayoutConstraint(item: tweetText!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: tweetText!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweetText!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: userName,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: tweetText!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: favorite,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -5.0).active = true
        
        //Profile Picture
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self.topLayoutGuide,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 50.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Bottom,
                           relatedBy: .LessThanOrEqual,
                           toItem: tableView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        //Username
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self.topLayoutGuide,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -5.0).active = true
        
        
        //Timestamp
        
        NSLayoutConstraint(item: timeStamp!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        
        NSLayoutConstraint(item: timeStamp!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self.topLayoutGuide,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: timeStamp!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -5.0).active = true
        
        //Favorite
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tableView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: favorite,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 30.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tableView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        tableViewLayout()
    }
    
    func makeUI(tweet: Tweet) {
        tweetText!.text = tweet.text
        userName!.text = tweet.userName
        if let url = NSURL(string: tweet.profilePic!) {
            profilePic!.setImageWithURL(url)
        }
        timeStamp!.text = tweet.getRelativeDate()
        self.tweet = tweet
        
        favorite?.addTarget(self, action: #selector(TweetCell.runFavorite(_:)), forControlEvents: .TouchUpInside)
        if !(tweet.alreadyFavorited!) {
            favorite?.setTitleColor(.blackColor(), forState: .Normal)
        } else {
            favorite?.setTitleColor(.redColor(), forState: .Normal)
        }
        if !(tweet.alreadyRetweeted!) {
            retweet?.addTarget(self, action: #selector(TweetCell.runRetweet(_:)), forControlEvents: .TouchUpInside)
            retweet?.enabled = true
            retweet?.setTitleColor(.blackColor(), forState: .Normal)
        } else {
            retweet?.enabled = false
            retweet?.setTitleColor(.grayColor(), forState: .Disabled)
            retweet?.setTitleColor(.grayColor(), forState: .Normal)
        }
    }
    
    func makeTableView() {
        tableView = UITableView()
        if let tableView = tableView {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerClass(CommentCell.self, forCellReuseIdentifier: "cell")
            tableView.estimatedRowHeight = 100.0
            tableView.rowHeight = UITableViewAutomaticDimension
            self.view.addSubview(tableView)
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func tableViewLayout() {
            NSLayoutConstraint(item: tableView!,
                               attribute: .Leading,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .LeadingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: tableView!,
                               attribute: .Trailing,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .TrailingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: tableView!,
                               attribute: .Top,
                               relatedBy: .Equal,
                               toItem: retweet,
                               attribute: .Bottom,
                               multiplier: 1.0,
                               constant: 10.0).active = true
            
            NSLayoutConstraint(item: tableView!,
                               attribute: .Bottom,
                               relatedBy: .Equal,
                               toItem: self.bottomLayoutGuide,
                               attribute: NSLayoutAttribute.Top,
                               multiplier: 1.0,
                               constant: 10.0).active = true
    }
    
    func runFavorite(sender : AnyObject?) {
        APICall.favoriteTweet(self.tweet!, unfavorite: tweet!.alreadyFavorited!)
        if (tweet!.alreadyFavorited!) {
            favorite?.setTitleColor(.blackColor(), forState: .Normal)
            tweet!.alreadyFavorited = false
        } else {
            favorite?.setTitleColor(.redColor(), forState: .Normal)
        }
    }
    
    func runRetweet(sender : AnyObject?) {
        APICall.retweetTweet(self.tweet!)
        retweet?.setTitleColor(.grayColor(), forState: .Normal)
        retweet?.setTitleColor(.grayColor(), forState: .Disabled)
        retweet?.enabled = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
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
