//
//  TweetDisplay.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/29/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import Foundation
import UIKit

class TweetDisplay {
    var viewController : TweetViewController
    var tweet : Tweet
    var tweetText : UILabel?
    var profilePic : UIImageView?
    var userName : UILabel?
    var timeStamp : UILabel?
    var favorite : UIButton?
    var retweet : UIButton?
    var reply : UIButton?
    var myStyle : UIStyle
    
    
    init(viewController : TweetViewController, tweet : Tweet) {
        self.viewController = viewController
        self.tweet = tweet
        self.myStyle = UIStyle()
    }
    
    func displayTweet() {
        setUpTweetFeatures()
        layout()
    }
    
    func setUpTweetFeatures() {
        tweetText = UILabel()
        if let tweetText = tweetText {
            tweetText.numberOfLines = 0
            tweetText.lineBreakMode = .ByWordWrapping
            tweetText.font = myStyle.normalFont
            
            tweetText.backgroundColor = .whiteColor()
            viewController.view.addSubview(tweetText)
            
            tweetText.translatesAutoresizingMaskIntoConstraints = false
        }
        profilePic = UIImageView()
        if let profilePic = profilePic {
            viewController.view.addSubview(profilePic)
            
            profilePic.translatesAutoresizingMaskIntoConstraints = false
        }
        userName = UILabel()
        if let userName = userName {
            viewController.view.addSubview(userName)
            userName.font = myStyle.boldFont
            
            userName.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeStamp = UILabel()
        if let timeStamp = timeStamp {
            viewController.view.addSubview(timeStamp)
            timeStamp.font = myStyle.normalFont
            timeStamp.textColor = .grayColor()
            timeStamp.translatesAutoresizingMaskIntoConstraints = false
        }
        
        favorite = UIButton()
        if let favorite = favorite {
            viewController.view.addSubview(favorite)
            favorite.setTitleColor(.blackColor() , forState: .Normal)
            favorite.titleLabel!.font = myStyle.normalFont
            favorite.titleLabel!.textAlignment = .Left
            favorite.setTitle("<3", forState: .Normal)
            favorite.translatesAutoresizingMaskIntoConstraints = false
        }
        
        retweet = UIButton()
        if let retweet = retweet {
            viewController.view.addSubview(retweet)
            retweet.setTitleColor(.blackColor() , forState: .Normal)
            retweet.titleLabel!.font = myStyle.normalFont
            retweet.titleLabel!.textAlignment = .Left
            retweet.setTitle("RT", forState: .Normal)
            retweet.translatesAutoresizingMaskIntoConstraints = false
        }
        
        reply = UIButton()
        if let reply = reply {
            viewController.view.addSubview(reply)
            reply.setTitleColor(.blackColor() , forState: .Normal)
            reply.titleLabel!.font = myStyle.normalFont
            reply.titleLabel!.textAlignment = .Left
            reply.setTitle("Reply", forState: .Normal)
            reply.translatesAutoresizingMaskIntoConstraints = false
        }
        makeUI(tweet)
        
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
                           toItem: viewController.view,
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
                           toItem: viewController.view,
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
                           toItem: viewController.topLayoutGuide,
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
                           toItem: viewController.view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 50.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Bottom,
                           relatedBy: .LessThanOrEqual,
                           toItem: viewController.view, //tableView
            attribute: .Bottom, //.Top
            multiplier: 0.5, //1.0
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
                           toItem: viewController.view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: viewController.topLayoutGuide,
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
                           toItem: viewController.view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        
        NSLayoutConstraint(item: timeStamp!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: viewController.topLayoutGuide,
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
                           toItem: viewController.view,
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
        
        /*
         NSLayoutConstraint(item: favorite!,
         attribute: .Bottom,
         relatedBy: .Equal,
         toItem: viewController.view, //tableView,
         attribute: .Bottom, //.Top,
         multiplier: 0.5, //1.0
         constant: 10.0).active = true
         */
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
        
        /*
         NSLayoutConstraint(item: retweet!,
         attribute: .Bottom,
         relatedBy: .Equal,
         toItem: viewController.view, //tableView,
         attribute: .Bottom, //.Top,
         multiplier: 0.5, //1.0
         constant: 10.0).active = true
         */
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: viewController.view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: retweet,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: viewController.view,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 50.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        //tableViewLayout()
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
        
        //reply?.addTarget(self, action: #selector(runReply(_:)), forControlEvents: .TouchUpInside)
    }
    
    func runFavorite(sender : AnyObject?) {
        APICall.favoriteTweet(self.tweet, unfavorite: tweet.alreadyFavorited!,
                              toDo: {(tweet : Tweet) in
                                self.tweet = tweet
                                self.favorite?.setTitle("<3 \(tweet.favoriteCount!)", forState: .Normal)
        })
        if (tweet.alreadyFavorited!) {
            favorite?.setTitleColor(.blackColor(), forState: .Normal)
            tweet.alreadyFavorited = false
        } else {
            favorite?.setTitleColor(.redColor(), forState: .Normal)
        }
    }
    
    func runRetweet(sender : AnyObject?) {
        APICall.retweetTweet(self.tweet, toDo: {(tweet : Tweet) in
            self.tweet = tweet
            self.retweet?.setTitle("RT \(tweet.retweetCount!)", forState: .Normal)
        })
        retweet?.setTitleColor(.grayColor(), forState: .Normal)
        retweet?.setTitleColor(.grayColor(), forState: .Disabled)
        retweet?.enabled = false
    }
    
    func runReply(sender: AnyObject) {
        let nextVC = TweetViewController()
        nextVC.presetText = "@\(tweet.screenName!)"
        nextVC.replyID = tweet.id!
        viewController.navigationController?.presentViewController(nextVC, animated: true, completion: nil)
    }
}