//
//  DataSource.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    var cellIdentifier : String
    var tweets : [Tweet]
    var segue : (tweet : Tweet) -> Void
    var toUser : (user : User) -> Void
    var isMoreDataLoading : Bool = false
    var scrolling : (scrollView : UIScrollView) -> Void
    
    init(cell : String, tweets : [Tweet], segue : (tweet: Tweet) -> Void, toUser : (user : User) -> Void, scrolling : (scrollView : UIScrollView) -> Void) {
        self.cellIdentifier = cell
        self.tweets = tweets
        self.segue = segue
        self.toUser = toUser
        self.scrolling = scrolling
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TweetCell
        cell.selectionStyle = .None
        cell.makeUI(tweets[indexPath.row])
        cell.setUserSegue(toUser)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        segue(tweet: tweets[indexPath.row])
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.scrolling(scrollView: scrollView)
    }

}
