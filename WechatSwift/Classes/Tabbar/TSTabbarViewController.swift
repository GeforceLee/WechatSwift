//
//  TSTabbarViewController.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Cent
class TSTabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    
    
    func setupViewController() {
        let titleArray = ["微信","通讯录","发现","我"]
        let normalImagesArray = [
            Asset.Tabbar_mainframe.image,
            Asset.Tabbar_contacts.image,
            Asset.Tabbar_discover.image,
            Asset.Tabbar_me.image
        ]
        
        let selectedImagesArray = [
            Asset.Tabbar_mainframeHL.image,
            Asset.Tabbar_contactsHL.image,
            Asset.Tabbar_discoverHL.image,
            Asset.Tabbar_meHL.image
        ]
        
        let viewControllerArray = [
            TSMessageViewController.initFromNib(),
            TSContactsViewController.initFromNib(),
            TSDiscoverViewController.initFromNib(),
            TSMeViewController.initFromNib()
        ]
        
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerate() {
            controller.tabBarItem!.title = titleArray.get(index)
            controller.tabBarItem!.image = normalImagesArray.get(index).imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem!.selectedImage = selectedImagesArray.get(index).imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(colorNamed: TSColor.tabbarSelectedTextColor)], forState: .Selected)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationVCArray.addObject(navigationController)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
        
    }
}