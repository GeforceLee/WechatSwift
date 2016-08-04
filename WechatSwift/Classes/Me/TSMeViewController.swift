//
//  TSMeViewController.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//


class TSMeViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    private let itemDataSource: [[(name: String, iconImage: UIImage?)]] = [
        [
            ("",nil)
        ],
        [
            ("相册",Asset.MoreMyAlbum.image),
            ("收藏", Asset.MoreMyFavorites.image),
            ("钱包", Asset.MoreMyBankCard.image),
            ("优惠券", Asset.MyCardPackageIcon.image)
        ],
        [
            ("表情",Asset.MoreExpressionShops.image)
        ],
        [
            ("设置", Asset.MoreSetting.image)
        ]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我"
        self.view.backgroundColor = UIColor(colorNamed: TSColor.viewBackgroundColor)
        
        self.listTableView.registerNib(TSMeAvatarTableViewCell.NibObject(), forCellReuseIdentifier: TSMeAvatarTableViewCell.identifier)
        self.listTableView.registerNib(TSImageTextTableViewCell.NibObject(), forCellReuseIdentifier: TSImageTextTableViewCell.identifier)
        self.listTableView.tableFooterView = UIView()
        
    }
    
    
    deinit {
        log.verbose("deinit")
    }
    
    
    
    
}



extension TSMeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension TSMeViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.itemDataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSource[section]
        return rows.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88.0
        } else {
            return 44.0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(TSMeAvatarTableViewCell.identifier, forIndexPath: indexPath)
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier (TSImageTextTableViewCell.identifier, forIndexPath: indexPath) as! TSImageTextTableViewCell
            let item = self.itemDataSource[indexPath.section][indexPath.row]
            
            cell.iconImageView.image = item.iconImage
            cell.titleLabel.text = item.name
            return cell
        }
    }
    
}















