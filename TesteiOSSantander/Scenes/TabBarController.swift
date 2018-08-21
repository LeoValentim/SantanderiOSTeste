//
//  TabBarController.swift
//  TesteiOSSantander
//
//  Created by Mac on 21/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import Cartography

class TabBarController: UITabBarController {
    
    var selectionIndicator : UIView!
    lazy var customTabBar: TabBar = {
        let customTabBar = TabBar(frame: self.tabBar.frame)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.backgroundColor = self.tabBar.barTintColor
        customTabBar.tintColor = self.tabBar.tintColor
        return customTabBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup custom top bar
        self.tabBar.isHidden = true
        customTabBar.setup()
        self.view.addSubview(customTabBar)
        constrain(customTabBar, self.view) { tabbar, view in
            tabbar.bottom == view.bottom
            tabbar.width == view.width
            tabbar.centerX == view.centerX
        }
        constrain(customTabBar, self.tabBar) { tabbar, tabbar2 in
            tabbar.height == tabbar2.height
        }
        
        let viewHeight : CGFloat = 3
        self.selectionIndicator = UIView(frame: CGRect(x: 0, y: self.tabBar.frame.origin.y - viewHeight, width: UIScreen.main.bounds.width / CGFloat(self.tabBar.items?.count ?? 2), height: viewHeight))
        self.selectionIndicator.backgroundColor = #colorLiteral(red: 1, green: 0.2117647059, blue: 0.2039215686, alpha: 1)
        self.view.addSubview(selectionIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TabBarController: TabBarDataSource {
    func tabBarItemsInCustomTabBar(tabBarView: TabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
}

extension TabBarController: TabBarDelegate {
    func didSelectViewController(tabBarView: TabBar, atIndex index: Int) {
        self.selectedIndex = index
        
        let viewWidth : CGFloat = UIScreen.main.bounds.width / CGFloat(self.tabBar.items?.count ?? 2)
        let viewHeight : CGFloat = 3
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 2.5, options: .overrideInheritedOptions, animations: {
            self.selectionIndicator.frame = CGRect(x: viewWidth * CGFloat(index), y: self.tabBar.frame.origin.y - viewHeight, width: viewWidth, height: viewHeight)
        }, completion: nil)
    }
}
