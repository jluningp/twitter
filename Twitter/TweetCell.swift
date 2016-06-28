//
//  TweetCell.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    var tweet : Tweet?
    var tweetText : UILabel?
    var profilePic : UIImageView?
    var userName : UILabel?
    var timeStamp : UILabel?
    var favorite : UIButton?
    var retweet : UIButton?
    
    var myStyle = UIStyle()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tweetText = UILabel()
        if let tweetText = tweetText {
            tweetText.numberOfLines = 0
            tweetText.lineBreakMode = .ByWordWrapping
            tweetText.font = myStyle.normalFont
            
            tweetText.backgroundColor = .whiteColor()
            contentView.addSubview(tweetText)
            
            tweetText.translatesAutoresizingMaskIntoConstraints = false
        }
        profilePic = UIImageView()
        if let profilePic = profilePic {
            contentView.addSubview(profilePic)
            
            profilePic.translatesAutoresizingMaskIntoConstraints = false
        }
        userName = UILabel()
        if let userName = userName {
            contentView.addSubview(userName)
            userName.font = myStyle.boldFont
            
            userName.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeStamp = UILabel()
        if let timeStamp = timeStamp {
            contentView.addSubview(timeStamp)
            timeStamp.font = myStyle.normalFont
            timeStamp.textColor = .grayColor()
            timeStamp.translatesAutoresizingMaskIntoConstraints = false
        }
        
        favorite = UIButton()
        if let favorite = favorite {
            contentView.addSubview(favorite)
            favorite.setTitleColor(.blackColor() , forState: .Normal)
            favorite.titleLabel!.font = myStyle.normalFont
            favorite.titleLabel!.textAlignment = .Left
            favorite.setTitle("<3", forState: .Normal)
            favorite.translatesAutoresizingMaskIntoConstraints = false
        }
        
        retweet = UIButton()
        if let retweet = retweet {
            contentView.addSubview(retweet)
            retweet.setTitleColor(.blackColor() , forState: .Normal)
            retweet.titleLabel!.font = myStyle.normalFont
            retweet.titleLabel!.textAlignment = .Left
            retweet.setTitle("RT", forState: .Normal)
            retweet.translatesAutoresizingMaskIntoConstraints = false
        }
        
        layout()
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
                           toItem: contentView,
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
                           toItem: contentView,
                           attribute: .Leading,
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
                           toItem: contentView,
                           attribute: .TopMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
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
                           toItem: contentView,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 50.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Bottom,
                           relatedBy: .LessThanOrEqual,
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
 
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
                           toItem: contentView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .TopMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
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
                           toItem: contentView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
 
        
        NSLayoutConstraint(item: timeStamp!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .TopMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
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
                           toItem: contentView,
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
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
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
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
