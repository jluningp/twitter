//
//  Error.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import Foundation

class Error {
    class func callErrorAndLogout(message : String) {
        print("Error: \(message) (Will Logout)")
        APICall.logout()
    }
    
    class func callErrorAndNotify(message : String) {
        print(message)
    }
}
