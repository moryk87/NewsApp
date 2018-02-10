//
//  SavedArticlesTableViewCell.swift
//  NewsApp
//
//  Created by Jan Moravek on 09/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import SwipeCellKit

class SavedArticlesTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
