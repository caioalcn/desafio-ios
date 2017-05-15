//
//  Repository.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import Foundation

class Repository {
    
    private var _id = 0
    private var _name = ""
    private var _full_name = ""
    private var _owner = User()
    private var _html_url = ""
    private var _descriptionRepo = ""
    private var _pulls_url = ""
    private var _stargazers_count = 0
    private var _forks_count = 0
    
    var id: Int {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    var full_name: String {
        return _full_name
    }
    
    var owner: User {
        return _owner
    }
    
    var html_url: String {
        return _html_url
    }
    
    var descriptionRepo: String {
        return _descriptionRepo
    }
    
    var pulls_url: String {
        return _pulls_url
    }
    
    var stargazers_count: Int {
        return _stargazers_count
    }
    
    var forks_count: Int{
        return _forks_count
    }
    
    init(dataLoaded: NSDictionary) {
        
        if let id = dataLoaded["id"] as? Int {
            self._id = id
        }
        
        if let name = dataLoaded["name"] as? String {
            self._name = name.capitalized
        }
        
        if let full_name = dataLoaded["full_name"] as? String {
            self._full_name = full_name
        }
        
        if let owner = dataLoaded["owner"] as? NSDictionary {
            self._owner = User(dataLoaded: owner)
        }
        
        if let html_url = dataLoaded["html_url"] as? String {
            self._html_url = html_url
        }
        
        if let descriptionRepo = dataLoaded["description"] as? String {
            self._descriptionRepo = descriptionRepo
        }
        
        if let pulls_url = dataLoaded["pulls_url"] as? String {
            self._pulls_url = pulls_url.replacingOccurrences(of: "{/number}", with: "")
            
        }
        
        if let stargazers_count = dataLoaded["stargazers_count"] as? Int {
            self._stargazers_count = stargazers_count
        }
        
        if let forks_count = dataLoaded["forks_count"] as? Int {
            self._forks_count = forks_count
        }
    }
    
}
