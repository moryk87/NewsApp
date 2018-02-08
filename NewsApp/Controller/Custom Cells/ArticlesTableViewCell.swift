//
//  ArticlesTableViewCell.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

protocol ArticlesTableViewCellDelegate {
    func saveLocalyButtonPressed(didSelect: ArticlesTableViewCell)
}

class ArticlesTableViewCell: UITableViewCell {
    
    var delegate: ArticlesTableViewCellDelegate?
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        self.delegate?.saveLocalyButtonPressed(didSelect: self)
        
        print("pressed")
    }
    
}
