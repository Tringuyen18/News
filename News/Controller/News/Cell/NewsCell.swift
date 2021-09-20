//
//  NewsCell.swift
//  NewsCell
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import UIKit

class NewsCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 12.0
        thumbnail.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
