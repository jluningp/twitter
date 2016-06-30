//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    var tableView : UITableView?
    
    var headerView : UIView?
    var profilePic : UIImageView?
    var userName : UILabel?
    var tagLine : UILabel?
    
    var tweets : UILabel?
    var following : UILabel?
    var followers : UILabel?
    
    var dividerLabel : UILabel?
    
    var navigationBar : UINavigationBar?
    var style = UIStyle()
    var cellIdentifier = "cell"
    var dataSource : DataSource?
    var newTweet : UIBarButtonItem?
    var user : User?
    
    var loadingMoreView : InfiniteScrollActivityView?
    var numberOfTweets : Int = 20
    var isMoreDataLoading : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = DataSource(cell: "cell", tweets: [Tweet](), segue: segue, toUser: self.viewProfile, scrolling: self.infiniteScroll, navControl: self.navigationController!)
        
        newTweet = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(makeNewTweet(_:)))
        navigationItem.rightBarButtonItem = newTweet
        
        if let user = user {
            self.title = "\(user.screenname!)"
        }
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = style.backgroundColor
        
        navigationBar = self.navigationController?.navigationBar
        if navigationBar == nil {
            Error.callErrorAndLogout("navigationBar is nil")
            return
        }
        
        self.navigationBar!.backgroundColor = style.twitterColor
        
        headerView = UIView()
        if let headerView = headerView {
            headerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(headerView)
        }
        
        profilePic = UIImageView()
        if let profilePic = profilePic {
            if let user = user {
                profilePic.setImageWithURL(user.profileURL!)
            }
            profilePic.translatesAutoresizingMaskIntoConstraints = false
            self.headerView!.addSubview(profilePic)
        }
        
        userName = UILabel()
        if let userName = userName {
            userName.translatesAutoresizingMaskIntoConstraints = false
            if let user = user {
                userName.text = "\(user.name!)"
            }
            self.headerView!.addSubview(userName)
        }
        
        tagLine = UILabel()
        if let tagLine = tagLine {
            tagLine.translatesAutoresizingMaskIntoConstraints = false
            tagLine.font = style.normalFont
            tagLine.numberOfLines = 0
            if let user = user {
                tagLine.text = "\(user.tagline!)"
            }
            self.headerView!.addSubview(tagLine)
        }
        
        followers = UILabel()
        if let followers = followers {
            followers.translatesAutoresizingMaskIntoConstraints = false
            followers.font = style.normalFont
            followers.numberOfLines = 0
            followers.textAlignment = .Center
            followers.text = "followers\n\(user!.followers!)"
            self.headerView!.addSubview(followers)
        }

        following = UILabel()
        if let following = following {
            following.translatesAutoresizingMaskIntoConstraints = false
            following.font = style.normalFont
            following.numberOfLines = 0
            following.textAlignment = .Center
            following.text = "following\n\(user!.following!)"
            self.headerView!.addSubview(following)
        }
        
        tweets = UILabel()
        if let tweets = tweets {
            tweets.translatesAutoresizingMaskIntoConstraints = false
            tweets.font = style.normalFont
            tweets.numberOfLines = 0
            tweets.textAlignment = .Center
            tweets.text = "tweets\n\(user!.tweets!)"
            self.headerView!.addSubview(tweets)
        }
        
        dividerLabel = UILabel()
        if let dividerLabel = dividerLabel {
            dividerLabel.backgroundColor = .grayColor()
            dividerLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(dividerLabel)
        }
        
        tableView = UITableView()
        if let tableView = tableView {
            tableView.delegate = dataSource
            tableView.dataSource = dataSource
            tableView.registerClass(TweetCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.estimatedRowHeight = 100.0
            tableView.rowHeight = UITableViewAutomaticDimension
            self.view.addSubview(tableView)
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let frame = CGRectMake(0, tableView!.contentSize.height, tableView!.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView!.addSubview(loadingMoreView!)
        
        var insets = tableView!.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView!.contentInset = insets
        
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
                           toItem: dividerLabel,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: tableView!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self.bottomLayoutGuide,
                           attribute: NSLayoutAttribute.Top,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: headerView!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self.topLayoutGuide,
                           attribute: NSLayoutAttribute.Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: headerView!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: headerView!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true

        NSLayoutConstraint(item: headerView!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: dividerLabel,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .TopMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: userName,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: profilePic!,
                           attribute: .Bottom,
                           relatedBy: .LessThanOrEqual,
                           toItem: headerView,
                           attribute: .BottomMargin,
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
                           toItem: headerView,
                           attribute: .Width,
                           multiplier: 0.0,
                           constant: 50.0).active = true
        
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
                           toItem: headerView,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .TopMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: userName!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tagLine,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -10.0).active = true

        //Tagline

        NSLayoutConstraint(item: tagLine!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: tagLine!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tagLine!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: userName,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: tagLine!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tweets,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        //Tweets
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: profilePic,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: following,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tagLine,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: following,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: followers,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        
        //Following
        
        NSLayoutConstraint(item: following!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: following!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: tweets,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: following!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: followers,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: following!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tagLine,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        
        //Followers
        
        NSLayoutConstraint(item: followers!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .BottomMargin,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: followers!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: following,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: followers!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: tweets!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: tagLine,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true

        
        

        //Divider Label


        NSLayoutConstraint(item: dividerLabel!,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .LeadingMargin,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: dividerLabel!,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .TrailingMargin,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: dividerLabel!,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: headerView,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 10.0).active = true
        
        NSLayoutConstraint(item: dividerLabel!,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: tableView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: -10.0).active = true
        
        NSLayoutConstraint(item: dividerLabel!,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: view,
                           attribute: .Height,
                           multiplier: 0.0,
                           constant: 1.0).active = true

        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView!.insertSubview(refreshControl, atIndex: 0)
        
        refreshTweets(useTweets)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func refreshTweets(closure : (dict : [NSDictionary]?) -> Void) {
        if let user = user {
            APICall.useProfileTweets(user, useTweets: closure, count: numberOfTweets)
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refreshTweets() { (dict : [NSDictionary]?) -> Void in
            self.useTweets(dict)
            refreshControl.endRefreshing()
        }
    }
    
    func segue(tweet: Tweet) {
        let newVC = DetailsViewController()
        newVC.tweet = tweet
        self.navigationController?.pushViewController(newVC, animated: false)
    }
    
    func useTweets(dict : [NSDictionary]?) {
        if let dict = dict {
            var tweets = [Tweet]()
            for tweet in dict {
                tweets.append(Tweet(tweetDictionary: tweet))
            }
            dataSource!.tweets = tweets
            if let tableView = tableView {
                tableView.reloadData()
            } else {
                Error.callErrorAndLogout("tableView is nil")
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let user = user {
            if let current = User.currentUser {
                if user.screenname == current.screenname  {
                    APICall.refreshUser({() -> Void in
                    self.tweets!.text = "tweets\n\(User.currentUser!.tweets!)"
                    self.followers!.text = "followers\n\(User.currentUser!.followers!)"
                    self.following!.text = "following\n\(User.currentUser!.following!)"})  //Need continuation here to update tweets number etc)
                }
            }
        }
    }
    
    func makeNewTweet(sender: AnyObject) {
        let nextVC = TweetViewController()
        self.navigationController?.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func viewProfile(user : User) {
        let nextVC = ProfileViewController()
        nextVC.user = user
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func infiniteScroll(scrollView : UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView!.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView!.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView!.dragging) {
                let frame = CGRectMake(0, tableView!.contentSize.height, tableView!.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                isMoreDataLoading = true
                numberOfTweets += 20
                
                refreshTweets() { (dict : [NSDictionary]?) -> Void in
                    self.useTweets(dict)
                    self.isMoreDataLoading = false
                    self.loadingMoreView!.stopAnimating()
                }
                
            }
        }
    }
    
    
}

