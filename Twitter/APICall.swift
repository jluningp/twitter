//
//  APICall.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class APICall {
    
    static var last15MinuteInterval : NSDate?
    static var callsInLastInterval : Int?
    
    static var _requestTokenString : String?
    
    static var requestTokenString : String? {
        get {
            if _requestTokenString == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("requestTokenStringData") as? String
                _requestTokenString = userData
            }
            return _requestTokenString
        }
        
        set(requestToken) {
            _requestTokenString = requestToken
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let requestToken = requestToken {
                defaults.setObject(requestToken, forKey: "requestTokenStringData")
            } else {
                defaults.setObject(nil, forKey: "requestTokenStringData")
            }
            defaults.synchronize()
        }
    }
    
    class func logout() {
        let apiURL = NSURL(string: "https://api.twitter.com")
        let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL!, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
        twitterClient.deauthorize()
        User.currentUser = nil
        APICall.requestTokenString = nil
    }
    
    class func loginOAuth() {
        let apiURL = NSURL(string: "https://api.twitter.com")
        if let apiURL = apiURL {
            let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
            
            twitterClient.deauthorize()
            
            twitterClient.fetchRequestTokenWithPath("https://api.twitter.com/oauth/request_token", method: "GET", callbackURL: NSURL(string: "fbutwitter://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential!) in
                
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                if let url = url {
                    UIApplication.sharedApplication().openURL(url)
                    
                } else {
                    Error.callErrorAndLogout("oauth url was nil")
                }
                
                }, failure: { (error: NSError!) in
                    Error.callErrorAndLogout("Failed to Access OAuth Authorization")
            })
        } else {
            Error.callErrorAndLogout("apiURL was nil")
        }

    }
    
    class func logInAndSetUser(urlQuery: String, toExecute: () -> Void ) {
        let requestToken = BDBOAuth1Credential(queryString: urlQuery)
        let apiURL = NSURL(string: "https://api.twitter.com")
        if let apiURL = apiURL {
            let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
            
            twitterClient.fetchAccessTokenWithPath("https://api.twitter.com/oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken : BDBOAuth1Credential!) -> Void in
                
                twitterClient.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
                    
                    let userDictionary = response as! NSDictionary
                    User.currentUser = User(dictionary: userDictionary)
                    
                    toExecute()
            
                    }, failure: { (task, error) in
                        Error.callErrorAndLogout(error.localizedDescription)
                })
                
                
                }, failure: { (error : NSError!) -> Void in
                    Error.callErrorAndLogout(error.localizedDescription)
            })
        }
    }

    class func useHomeScreenTweets(useTweets : (tweets : [NSDictionary]?) -> Void) {
        if canMakeAPICall() {
                let apiURL = NSURL(string: "https://api.twitter.com")
                if let apiURL = apiURL {
                    let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
                    
                    twitterClient.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
                        let tweets = response as! [NSDictionary]
                        useTweets(tweets: tweets)
                        }, failure: { (task, error) in
                            Error.callErrorAndLogout("\(error.localizedDescription)")
                    })
                } else {
                    Error.callErrorAndLogout("API URL was nil")
                }
        } else {
            Error.callErrorAndNotify("Exceeded API Limit")
            useTweets(tweets: nil)
        }
    }
    
    class func retweetTweet(tweet: Tweet) {
        let apiURL = NSURL(string: "https://api.twitter.com")
        if let apiURL = apiURL {
            let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
            
            twitterClient.POST("1.1/statuses/retweet/\(tweet.id!).json", parameters: nil, progress: nil, success: { (task, response) in
                let tweet = response as! NSDictionary
                print(tweet)
                }, failure: { (task, error) in
                    Error.callErrorAndNotify("\(error.localizedDescription)")
            })
        } else {
            Error.callErrorAndLogout("API URL was nil")
        }
    }

    class func favoriteTweet(tweet: Tweet, unfavorite : Bool) {
        let apiURL = NSURL(string: "https://api.twitter.com")
        if let apiURL = apiURL {
            let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "rhsRQQl7HsJpv1V84AceVNkgu", consumerSecret: "NBOGQCnTIYP9hH970K8z9Gn5fvBSrg72vDWw3im3YZ9rG5N4O1")
            
            var postURL = "1.1/favorites/create.json?id=\(tweet.id!)"
            if unfavorite {
                postURL = "1.1/favorites/destroy.json?id=\(tweet.id!)"
            }
            
            twitterClient.POST(postURL, parameters: nil, progress: nil, success: nil, failure: { (task, error) in
                Error.callErrorAndNotify(error.localizedDescription)
            })
        } else {
            Error.callErrorAndLogout("API URL was nil")
        }
    }


    class func canMakeAPICall() -> Bool {
        if let last15 = APICall.last15MinuteInterval {
            let timeElapsed = last15.timeIntervalSinceNow
            let minutes = Int(timeElapsed) / 60 * -1
            if minutes < 15 {
                if let calls = APICall.callsInLastInterval {
                    if calls <= 15 {
                        APICall.callsInLastInterval = APICall.callsInLastInterval! + 1
                        return true
                    } else {
                        return false
                    }
                } else {
                    APICall.callsInLastInterval = 1
                    return true
                }
            } else {
                APICall.callsInLastInterval = 1
                APICall.last15MinuteInterval = NSDate()
                return true
            }
        } else {
            APICall.callsInLastInterval = 1
            APICall.last15MinuteInterval = NSDate()
            return true
        }
    }
    
}
