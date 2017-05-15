//
//  User.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import Foundation

class User {
    
    private var _id = 0
    private var _login = ""
    private var _avatar_url = ""
    private var _url = ""
    
    var id: Int {
        return _id
    }
    
    var login: String {
        return _login
    }
    
    var avatar_url: String {
        return _avatar_url
    }
    
    var url: String {
        return _url
    }
    
    convenience init(dataLoaded: NSDictionary) {
        self.init()
        
        if let id = dataLoaded["id"] as? Int {
            self._id = id
        }
        
        if let login = dataLoaded["login"] as? String {
            self._login = login
        }
        
        if let avatar_url = dataLoaded["avatar_url"] as? String {
            self._avatar_url = avatar_url
        }
        
        if let url = dataLoaded["url"] as? String {
            self._url = url
        }
    }
}
