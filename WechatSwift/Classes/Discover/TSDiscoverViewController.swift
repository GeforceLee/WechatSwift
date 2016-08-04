//
//  TSDiscoverViewController.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import UIKit

class TSDiscoverViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    private let itemDataSource: [[(name: String, iconImage: UIImage)]] = [
        [
            ("朋友圈", Asset.Ff_IconShowAlbum.image)
        ],
        [
            ("扫一扫", Asset.Ff_IconQRCode.image),
            ("摇一摇", Asset.Ff_IconShake.image)
        ],
        [
            ("附近的人", Asset.Ff_IconLocationService.image),
            ("漂流瓶", Asset.Ff_IconBottle.image)
        ],
        [
            ("游戏", Asset.MoreGame.image)
        ]
    
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发现"
        self.view.backgroundColor = UIColor(colorNamed: TSColor.viewBackgroundColor)
        self.listTableView.registerNib(TSImageTextTableViewCell.NibObject(), forCellReuseIdentifier: TSImageTextTableViewCell.identifier)
        self.listTableView.estimatedRowHeight = 44
        self.listTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        log.verbose("deinit")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    
}
extension TSDiscoverViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
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

extension TSDiscoverViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.itemDataSource.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSource[section]
        return rows.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TSImageTextTableViewCell.identifier) as! TSImageTextTableViewCell
        let item = self.itemDataSource[indexPath.section][indexPath.row]
        cell.iconImageView.image = item.iconImage
        cell.titleLabel.text = item.name
        return cell
    }
    
    
}








