//
//  Tweet.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import Foundation

class Tweet {
    
    var text : String?
    var userName : String?
    var profilePic : String?
    var timeStamp : NSDate?
    var id : String?
    var alreadyFavorited : Bool?
    var alreadyRetweeted : Bool?
    
    init(tweetDictionary : NSDictionary) {
        self.text = tweetDictionary["text"] as? String
        if let user = tweetDictionary["user"] {
            self.userName = user["name"] as? String
            self.profilePic = user["profile_image_url_https"] as? String
        }
        self.timeStamp = convertToNSDate(tweetDictionary["created_at"] as? String)
        self.id = tweetDictionary["id_str"] as? String
        self.alreadyFavorited = tweetDictionary["favorited"] as? Bool
        self.alreadyRetweeted = tweetDictionary["retweeted"] as? Bool
    }
    
    func convertToNSDate(str : String?) -> NSDate? {
        if let str = str {
            let dateFor: NSDateFormatter = NSDateFormatter()
            dateFor.dateFormat = "E MMM d HH:mm:ss Z yyyy"
            let nsDate: NSDate? = dateFor.dateFromString(str)
            return nsDate
        } else {
            return nil
        }
    }
    
    func getRelativeDate() -> String {
        let date = self.timeStamp!
        
        let relativeTime = date.timeIntervalSinceNow * -1.0
        
        let seconds = Int(relativeTime)
        let minutes = seconds / 60
        if minutes < 1 {
            return "\(seconds)s"
        }
        let hours = minutes / 60
        if hours < 1 {
            return "\(minutes)m"
        }
        let days = hours / 24
        if days < 1 {
            return "\(hours)h"
        }
        let weeks = days / 7
        if weeks < 1 {
            return "\(days)d"
        }
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "M/d/YY"
        
        return dateFor.stringFromDate(date)
    }
    
}