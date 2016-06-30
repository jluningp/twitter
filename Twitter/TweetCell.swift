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
    var favoriteCount : UILabel?
    var retweet : UIButton?
    var retweetCount : UILabel?
    var reply : UIButton?
    
    var userSegue : ((user : User) -> Void)?
    var navControl : UINavigationController?
    
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
            favorite.setBackgroundImage(UIImage(named: "like-action"), forState: .Normal)
            favorite.translatesAutoresizingMaskIntoConstraints = false
        }
        
        retweet = UIButton()
        if let retweet = retweet {
            contentView.addSubview(retweet)
            retweet.setTitleColor(.blackColor() , forState: .Normal)
            retweet.titleLabel!.font = myStyle.normalFont
            retweet.titleLabel!.textAlignment = .Left
            retweet.setBackgroundImage(UIImage(named: "retweet-off"), forState: .Normal)
            retweet.translatesAutoresizingMaskIntoConstraints = false
        }
        
        favoriteCount = UILabel()
        if let favoriteCount = favoriteCount {
            contentView.addSubview(favoriteCount)
            favoriteCount.font = myStyle.normalFont
            favoriteCount.text = "000"
            favoriteCount.translatesAutoresizingMaskIntoConstraints = false
        }
        
        retweetCount = UILabel()
        if let retweetCount = retweetCount {
            contentView.addSubview(retweetCount)
            retweetCount.font = myStyle.normalFont
            retweetCount.text = "000"
            retweetCount.translatesAutoresizingMaskIntoConstraints = false
        }
        
        reply = UIButton()
        if let reply = reply {
            contentView.addSubview(reply)
            reply.setBackgroundImage(UIImage(named: "reply-action"), forState: .Normal)
            reply.translatesAutoresizingMaskIntoConstraints = false
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
                           toItem: reply,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
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
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: favoriteCount,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .Height,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: favorite!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: favorite,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true

        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: favoriteCount,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .Height,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: retweet!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: retweet,
                           attribute: .Height,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        
        //Favorite Count
        
        NSLayoutConstraint(item: favoriteCount!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: favorite,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: favoriteCount!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: retweet,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: favoriteCount!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: favoriteCount!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        //Retweet Count
        
        NSLayoutConstraint(item: retweetCount!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: retweet,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: retweetCount!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: retweetCount!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: retweetCount!,
                           attribute: .Trailing,
                           relatedBy: .LessThanOrEqual,
                           toItem: contentView,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .Height,
                           multiplier: 0.0,
                           constant: 20.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: reply,
                           attribute: .Height,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tweetText,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 5.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: contentView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: reply!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: favorite,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
    }
    
    func makeUI(tweet: Tweet) {
        tweetText?.text = tweet.text
        userName?.text = tweet.userName
        if let url = NSURL(string: tweet.profilePic!) {
            profilePic?.setImageWithURL(url)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        
        profilePic?.userInteractionEnabled = true
        profilePic?.addGestureRecognizer(tap)
        
        
        timeStamp?.text = tweet.getRelativeDate()
        self.tweet = tweet
        
        favoriteCount?.text = "\(tweet.favoriteCount!)"
        favorite?.addTarget(self, action: #selector(TweetCell.runFavorite(_:)), forControlEvents: .TouchUpInside)
        if !(tweet.alreadyFavorited!) {
            favorite?.setBackgroundImage(UIImage(named: "like-action"), forState: .Normal)
        } else {
            favorite?.setBackgroundImage(UIImage(named: "like-action-on"), forState: .Normal)
        }
        retweetCount?.text = "\(tweet.retweetCount!)"
        retweet?.addTarget(self, action: #selector(TweetCell.runRetweet(_:)), forControlEvents: .TouchUpInside)
        if (tweet.alreadyRetweeted!) {
            retweet?.setBackgroundImage(UIImage(named: "retweet-on"), forState: .Normal)
        } else {
            retweet?.setBackgroundImage(UIImage(named: "retweet-off"), forState: .Normal)
        }
        reply?.addTarget(self, action: #selector(runReply(_:)), forControlEvents: .TouchUpInside)
    }
    
    func runFavorite(sender : AnyObject?) {
        APICall.favoriteTweet(self.tweet!, unfavorite: tweet!.alreadyFavorited!,
                              toDo: {(tweet : Tweet) in
                                self.tweet = tweet
                                self.favoriteCount?.text = "\(tweet.favoriteCount!)"
                                if !(self.tweet!.alreadyFavorited!) {
                                    self.favorite?.setBackgroundImage(UIImage(named: "like-action"), forState: .Normal)
                                } else {
                                    self.favorite?.setBackgroundImage(UIImage(named: "like-action-on"), forState: .Normal)
                                }
        })
    }
    
    func runRetweet(sender : AnyObject?) {
        let retweeted = tweet?.alreadyRetweeted
        APICall.retweetTweet(self.tweet!, toDo: {(tweet : Tweet) in
                self.tweet = tweet
                self.tweet!.alreadyRetweeted = !retweeted!
            if self.tweet!.alreadyRetweeted! {
                print("retweet")
                self.retweet?.setBackgroundImage(UIImage(named: "retweet-on"), forState: .Normal)
                self.retweetCount?.text = "\(tweet.retweetCount!)"
            } else {
                print("not retweet")
                self.retweetCount?.text = "\(tweet.retweetCount! - 1)"
                self.retweet?.setBackgroundImage(UIImage(named: "retweet-off"), forState: .Normal)
            }
        }, unReTweet: self.tweet!.alreadyRetweeted!)
    }
    
    func setUserSegue(toUser : (user : User) -> Void) {
        self.userSegue = toUser
    }
    
    func makeNavControl(navControl : UINavigationController) {
        self.navControl = navControl
    }
    
    func handleTap(sender : AnyObject?) {
        userSegue!(user: tweet!.user!)
    }
    
    func runReply(sender: AnyObject) {
        let nextVC = TweetViewController()
        nextVC.presetText = "@\(tweet!.screenName!)"
        nextVC.replyID = tweet!.id!
        self.navControl?.presentViewController(nextVC, animated: true, completion: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
