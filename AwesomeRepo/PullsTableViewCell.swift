//
//  PullsTableViewCell.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit
import SDWebImage

class PullsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noPRs: UILabel!
    @IBOutlet weak var titlePRLabel: UILabel!
    @IBOutlet weak var descriptionPRLabel: UILabel!
    @IBOutlet weak var userPRLabel: UILabel!
    @IBOutlet weak var datePRLabel: UILabel!
    @IBOutlet weak var userPRImage: UIImageView!
    
    func updateUI(pr: PullRequest) {
        
        titlePRLabel.text = pr.title
        descriptionPRLabel.text = pr.body
        userPRLabel.text = pr.user.login
        datePRLabel.text = pr.created_at
        
        userPRImage.sd_setImage(with: URL(string: pr.user.avatar_url), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    
}
