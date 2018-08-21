//
//  TabBar.swift
//  TesteiOSSantander
//
//  Created by Mac on 11/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

protocol TabBarDataSource {
    func tabBarItemsInCustomTabBar(tabBarView: TabBar) -> [UITabBarItem]
}

protocol TabBarDelegate {
    func didSelectViewController(tabBarView: TabBar, atIndex index: Int)
}

class TabBar: UIView {
    
    var datasource: TabBarDataSource!
    var delegate: TabBarDelegate!
    
    var tabBarItems: [UITabBarItem]!
    var customTabBarItems: [TabBarItem]!
    var tabBarButtons: [UIButton]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // get tab bar items from default tab bar
        tabBarItems = datasource.tabBarItemsInCustomTabBar(tabBarView: self)
        
        customTabBarItems = []
        tabBarButtons = []
        
        let containers = createTabBarItemContainers()
        createTabBarItems(containers: containers)
    }
    
    func createTabBarItems(containers: [CGRect]) {
        
        var index = 0
        for item in tabBarItems {
            
            let container = containers[index]
            
            let customTabBarItem = TabBarItem(frame: container)
            customTabBarItem.tintColor = self.tintColor
            customTabBarItem.setup(item: item)
            if index == 0 {
                customTabBarItem.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
            }
            
            self.addSubview(customTabBarItem)
            customTabBarItems.append(customTabBarItem)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: container.width, height: container.height))
            button.addTarget(self, action: #selector(self.barItemTapped(_:)), for: UIControlEvents.touchUpInside)
            
            customTabBarItem.addSubview(button)
            tabBarButtons.append(button)
            
            index += 1
        }
    }
    
    func createTabBarItemContainers() -> [CGRect] {
        
        var containerArray = [CGRect]()
        
        // create container for each tab bar item
        for index in 0..<tabBarItems.count {
            let tabBarContainer = createTabBarContainer(index: index)
            containerArray.append(tabBarContainer)
        }
        
        return containerArray
    }
    
    func createTabBarContainer(index: Int) -> CGRect {
        
        let tabBarContainerWidth = self.frame.width / CGFloat(tabBarItems.count)
        let tabBarContainerRect = CGRect(x: tabBarContainerWidth * CGFloat(index), y: 0, width: tabBarContainerWidth, height: self.frame.height)
        
        return tabBarContainerRect
    }
    
    @objc func barItemTapped(_ sender : UIButton) {
        let index = self.tabBarButtons.index(of: sender)!
        
        self.customTabBarItems.filter({ b in b.backgroundColor == #colorLiteral(red: 0.7843137255, green: 0.01568627451, blue: 0.01568627451, alpha: 1) }).forEach({ b in
            UIView.animate(withDuration: 0.3, animations: {
                b.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.003921568627, blue: 0.003921568627, alpha: 1)
            })
        })
        if self.customTabBarItems.indices.contains(index) {
            UIView.animate(withDuration: 0.3, animations: {
                self.customTabBarItems[index].backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
            })
        }
        
        self.delegate.didSelectViewController(tabBarView: self, atIndex: index)
    }
}
