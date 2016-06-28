//
//  DataSource.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier : String
    var tweets : [Tweet]
    var segue : (tweet : Tweet) -> Void
    
    init(cell : String, tweets : [Tweet], segue : (tweet: Tweet) -> Void) {
        self.cellIdentifier = cell
        self.tweets = tweets
        self.segue = segue
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TweetCell
        cell.makeUI(tweets[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        segue(tweet: tweets[indexPath.row])
    }
}
