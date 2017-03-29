//
//  MovieCell.swift
//  LTCPFlicks
//
//  Created by Tran, Leland on 3/29/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
