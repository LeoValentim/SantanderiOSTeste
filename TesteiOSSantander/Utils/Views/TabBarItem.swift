//
//  TabBarItem.swift
//  TesteiOSSantander
//
//  Created by Mac on 11/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import Cartography

class TabBarItem: UIView {
    
    var titlaLabel : UILabel!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: UITabBarItem) {
        if let title = item.title {
            self.titlaLabel = UILabel()
            self.titlaLabel.text = title
            self.titlaLabel.textAlignment = .center
            self.titlaLabel.font = UIFont(name: "DINPro-Medium", size: 16)
            self.titlaLabel.textColor = self.tintColor
            
            self.addSubview(self.titlaLabel)
            constrain(titlaLabel, self) { label, view in
                label.width == view.width - 8
                label.centerX == view.centerX
                label.centerY == view.centerY
            }
        }
    }
    
}
