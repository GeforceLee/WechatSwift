//
//  TSImageTextTableViewCell.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import UIKit

class TSImageTextTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .DisclosureIndicator
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
