//
//  RepositoryTableViewCell.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    func updateUI(repository: Repository) {
        
        titleLabel.text = repository.name
        descriptionLabel.text = repository.descriptionRepo
        userLabel.text = repository.owner.login
        nameLabel.text = repository.full_name
        
        let decimal = NumberFormatter()
        decimal.numberStyle = .decimal
        
        forkLabel.text = decimal.string(from: NSNumber(integerLiteral: repository.forks_count))
        starLabel.text = decimal.string(from: NSNumber(integerLiteral: repository.stargazers_count))
        
        userImage.sd_setImage(with: URL(string: repository.owner.avatar_url), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
}
