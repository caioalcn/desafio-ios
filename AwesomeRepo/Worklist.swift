//
//  Worklist.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import Foundation

class Worklist {
    
    func addRepositories(_ repositories: NSArray) -> Array<Repository>{
        
        var parsedRepositories = Array<Repository>()
        for repository in repositories {
            
            let loadRepositories = Repository.init(dataLoaded: repository as! NSDictionary)
            
            parsedRepositories.append(loadRepositories)
            
        }
        
        return parsedRepositories
    }
    
    func addPullRequests(_ pulls: NSArray) -> Array<PullRequest>{
        
        var parsedPulls = Array<PullRequest>()
        for pull in pulls {
            
            let loadPRs = PullRequest.init(dataLoaded: pull as! NSDictionary)
            
            parsedPulls.append(loadPRs)
            
        }
        
        return parsedPulls
    }
}
