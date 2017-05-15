//
//  PullRequestsViewController.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class PullRequestsViewController: UIViewController {
    
    @IBOutlet weak var tablePRs: UITableView!
    @IBOutlet weak var noPRs: UILabel!
    
    var url = ""
    var titleRepo = ""
    var prs = [PullRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PullRequestsViewController.getPullRequests(notification:)), name:NSNotification.Name(rawValue: "getPullRequests"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PullRequestsViewController.failGetPullRequests(notification:)), name:NSNotification.Name(rawValue: "failGetPullRequests"), object: nil)
        
        self.navigationItem.title = titleRepo
        tablePRs.tableFooterView = UIView()
        
        APIRequest().getPullRequests(repoPullUrl: url)
        KRProgressHUD.show()
    }
    
    
    func getPullRequests(notification: NSNotification) {
        
        let all = notification.object as! NSArray
        
        if let pulls = all as? Array<PullRequest> {
            for pull in pulls{
                
                prs.append(pull)
                
            }
        }
        
        if all.count == 0 {
            
            tablePRs.isHidden = true
            noPRs.isHidden = false
            
        } else {
            
            tablePRs.isHidden = false
            noPRs.isHidden = true
            
        }
        
        KRProgressHUD.dismiss()
        tablePRs.reloadData()
    }
    
    func failGetPullRequests(notification: NSNotification) {
        
        KRProgressHUD.showError()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPR" {
            
            let nvc = segue.destination as? PRWebViewController
            
            if let indexPath = tablePRs.indexPathForSelectedRow {
                
                nvc?.prUrl = prs[indexPath.row].html_url
            }
        }
    }
}

extension PullRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pullCell", for: indexPath) as! PullsTableViewCell
        
        cell.updateUI(pr: prs[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
