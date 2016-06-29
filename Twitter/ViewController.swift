//
//  ViewController.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView?
    var navigationBar : UINavigationBar?
    var style = UIStyle()
    var cellIdentifier = "cell"
    var dataSource : DataSource?
    var newTweet : UIBarButtonItem?
    var myProfile : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = DataSource(cell: "cell", tweets: [Tweet](), segue: segue, toUser: self.viewProfile)
        
        newTweet = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(makeNewTweet(_:)))
        navigationItem.rightBarButtonItem = newTweet
        
        myProfile = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: #selector(viewMyProfile(_:)))
        navigationItem.leftBarButtonItem = myProfile
        
        self.title = "Twitter"
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = style.backgroundColor
        
        navigationBar = self.navigationController?.navigationBar
        if navigationBar == nil {
            Error.callErrorAndLogout("navigationBar is nil")
            return
        }
        
        self.navigationBar!.backgroundColor = style.twitterColor
        
        tableView = UITableView()
        if let tableView = tableView {
            tableView.delegate = dataSource
            tableView.dataSource = dataSource
            tableView.registerClass(TweetCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.estimatedRowHeight = 100.0
            tableView.rowHeight = UITableViewAutomaticDimension
            self.view.addSubview(tableView)
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint(item: tableView,
                               attribute: .Leading,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .LeadingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: tableView,
                               attribute: .Trailing,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .TrailingMargin,
                               multiplier: 1.0,
                               constant: 0.0).active = true
            
            NSLayoutConstraint(item: tableView,
                               attribute: .Top,
                               relatedBy: .Equal,
                               toItem: self.topLayoutGuide,
                               attribute: NSLayoutAttribute.Bottom,
                               multiplier: 1.0,
                               constant: 10.0).active = true
            
            NSLayoutConstraint(item: tableView,
                               attribute: .Bottom,
                               relatedBy: .Equal,
                               toItem: self.bottomLayoutGuide,
                               attribute: NSLayoutAttribute.Top,
                               multiplier: 1.0,
                               constant: 10.0).active = true
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView!.insertSubview(refreshControl, atIndex: 0)
        
        refreshTweets(setTweets)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func refreshTweets(closure : (dict : [NSDictionary]?) -> Void) {
        APICall.useHomeScreenTweets(closure)
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refreshTweets() { (dict : [NSDictionary]?) -> Void in
            self.setTweets(dict)
            refreshControl.endRefreshing()
        }
    }
    
    func segue(tweet: Tweet) {
        let newVC = DetailsViewController()
        newVC.tweet = tweet
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func setTweets(dict : [NSDictionary]?) {
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
    
    func makeNewTweet(sender: AnyObject) {
        let nextVC = TweetViewController()
        self.navigationController?.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func viewMyProfile(sender : AnyObject) {
        viewProfile(User.currentUser!)
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


}

