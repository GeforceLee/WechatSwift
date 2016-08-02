//
//  TSNavigationBar.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import SnapKit
class TSNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initContent()
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initContent() {
        let containerView: UIView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        self.addSubview(containerView)
        
        containerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top).offset(-20)
            make.left.equalTo(self.snp_left).offset(0)
            make.width.equalTo(44)
            make.height.equalTo(64)
        }
    }
    
}