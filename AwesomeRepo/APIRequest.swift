//
//  APIRequest.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import Foundation
import Alamofire

class APIRequest {
    
    private var urlBase = "https://api.github.com/search/repositories"
    
    func getAllRepositories(language: String, page: String){
        
        Alamofire.request(urlBase+"?q=language:\(language)&sort=stars&page=\(page)", method: .get, parameters: nil)
            .responseJSON { response in
                switch response.result{
                case .success:
                    if let value = response.result.value{
                        if let JSON = value as? NSDictionary{
                            if let repos = JSON["items"] as? NSArray{
                                
                                let repositories = Worklist().addRepositories(repos)
                                let pages = JSON["total_count"]
                                
                                let result = ["repos": repositories, "pages": pages]
                                
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "getAllRepositories"), object:result, userInfo:nil)
                            }
                        }
                    } else {
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "failGetAllRepositories"), object: nil, userInfo:nil)
                        
                    }
                    
                case .failure(let error):
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "failGetAllRepositories"), object: error, userInfo:nil)
                    
                }
        }
    }
    
    
    func getPullRequests(repoPullUrl: String){
        
        Alamofire.request(repoPullUrl, method: .get, parameters: nil)
            .responseJSON { response in
                switch response.result{
                case .success:
                    if let value = response.result.value{
                        if let JSON = value as? NSArray{
                            
                            let prs = Worklist().addPullRequests(JSON)
                            
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "getPullRequests"), object:prs, userInfo:nil)
                        }
                    } else {
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "failGetPullRequests"), object: nil, userInfo:nil)
                        
                    }
                    
                case .failure(let error):
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "failGetPullRequests"), object: error, userInfo:nil)
                    
                }
        }
    }
}
