//
//  TestCell.swift
//  CacheImageViewTest
//
//  Created by George Leonidas on 05/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    static let cellIdentifier = "TestCell"
    static let nibName = "TestCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
