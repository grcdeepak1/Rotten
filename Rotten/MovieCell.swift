//
//  MovieCell.swift
//  Rotten
//
//  Created by Deepak on 9/11/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    

    @IBOutlet var posterView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
