//
//  PullRequest.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class PullRequest: NSObject {
    
    private var _id = 0
    private var _html_url = ""
    private var _title = ""
    private var _user = User()
    private var _body = ""
    private var _created_at = ""
    
    var id: Int {
        return _id
    }
    
    var html_url: String {
        return _html_url
    }
    
    var title: String {
        return _title
    }
    
    var user: User {
        return _user
    }
    
    var body: String {
        return _body
    }
    
    var created_at: String {
        return _created_at
    }
    
    init(dataLoaded: NSDictionary) {
        
        if let id = dataLoaded["id"] as? Int {
            self._id = id
        }
        
        if let html_url = dataLoaded["html_url"] as? String {
            self._html_url = html_url
        }
        
        if let title = dataLoaded["title"] as? String {
            self._title = title.capitalized
        }
        
        if let user = dataLoaded["user"] as? NSDictionary {
            self._user = User(dataLoaded: user)
        }
        
        if let body = dataLoaded["body"] as? String {
            self._body = body
        }
        
        if let created_at = dataLoaded["created_at"] as? String {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd, yyyy - HH:mm:ss"
            
            let date = dateFormatterGet.date(from: created_at)
            let newDate = dateFormatterPrint.string(from: date!)
            
            self._created_at = newDate
        }
        
    }
}
