//
//  TSContactTableViewCell.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import UIKit

class TSContactTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setCellContent(model: ContactModel) -> Void {
        self.avatarImageView.ts_setImageWithURLString(model.avatarSmallURL, placeholderImage: Asset.Icon_avatar.image)
        self.usernameLabel.text = model.chineseName
    
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
