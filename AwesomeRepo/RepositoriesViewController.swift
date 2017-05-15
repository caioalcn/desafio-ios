//
//  RepositoriesViewController.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableRepo: UITableView!
    @IBOutlet weak var spinnerRepos: UIActivityIndicatorView!
    
    var repositories = [Repository]()
    var countPage = 1
    var totalPages = 0
    var language = "Java"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RepositoriesViewController.getAllRepositories(notification:)), name:NSNotification.Name(rawValue: "getAllRepositories"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RepositoriesViewController.failGetAllRepositories(notification:)), name:NSNotification.Name(rawValue: "failGetAllRepositories"), object: nil)
        
        
        getRepos(language: language, page: "\(countPage)")
        KRProgressHUD.show()
        
    }
    
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            language = "Swift"
            countPage = 1
            repositories.removeAll()
            tableRepo.reloadData()
            getRepos(language: language, page: "\(countPage)")
            KRProgressHUD.show()
            
            
        } else if sender.selectedSegmentIndex == 1 {
            
            language = "Java"
            countPage = 1
            repositories.removeAll()
            tableRepo.reloadData()
            getRepos(language: language, page: "\(countPage)")
            KRProgressHUD.show()
            
            
        } else if sender.selectedSegmentIndex == 2 {
            
            language = "Php"
            countPage = 1
            repositories.removeAll()
            tableRepo.reloadData()
            getRepos(language: language, page: "\(countPage)")
            KRProgressHUD.show()
            
        } else {
            
            language = "C#"
            countPage = 1
            repositories.removeAll()
            tableRepo.reloadData()
            getRepos(language: language, page: "\(countPage)")
            KRProgressHUD.show()
        }
        
    }
    
    func getAllRepositories(notification: NSNotification) {
        
        let all = notification.object as! NSDictionary
        
        if let repos = all["repos"] as? Array<Repository> {
            for repository in repos{
                
                repositories.append(repository)
                
            }
        }
        
        if let count = all["pages"] as? Int {
            
            totalPages = count
        }
        
        spinnerRepos.stopAnimating()
        KRProgressHUD.dismiss()
        tableRepo.reloadData()
    }
    
    func failGetAllRepositories(notification: NSNotification) {
        
        KRProgressHUD.showError()
        
    }
    
    
    func getRepos(language: String, page: String) {
        
        APIRequest().getAllRepositories(language: language, page: page)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPulls" {
            
            let nvc = segue.destination as? PullRequestsViewController
            
            if let indexPath = tableRepo.indexPathForSelectedRow {
                
                nvc?.url = repositories[indexPath.row].pulls_url
                nvc?.titleRepo = repositories[indexPath.row].name
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTableViewCell
        
        cell.updateUI(repository: repositories[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == repositories.count - 1{
            
            if countPage < totalPages {
                spinnerRepos.startAnimating()
                countPage += 1
                getRepos(language: language, page: "\(countPage)")
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
