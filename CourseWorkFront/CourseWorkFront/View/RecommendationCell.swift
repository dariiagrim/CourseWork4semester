//
//  RecommendationCell.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 29.05.2021.
//

import UIKit

class RecommendationCell: UITableViewCell {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
