//
//  RadioButton.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import Cartography

class RadioButton: UIView {
    
    lazy var radioBoxInticator: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: 19))
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var radioInnerBoxInticator: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.layer.cornerRadius = 3
        view.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.003921568627, blue: 0.003921568627, alpha: 1)
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DINPro-Regular", size: 16)
        label.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        label.text = labelText
        return label
    }()
    
    var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                radioInnerBoxInticator.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.003921568627, blue: 0.003921568627, alpha: 1)
            } else {
                radioInnerBoxInticator.backgroundColor = .clear
            }
        }
    }
    
    var didChangeSelection: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
        setupConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initView() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction)))
        
        self.addSubview(radioBoxInticator)
        
        if isSelected {
            radioInnerBoxInticator.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.003921568627, blue: 0.003921568627, alpha: 1)
        } else {
            radioInnerBoxInticator.backgroundColor = .clear
        }
        radioBoxInticator.addSubview(radioInnerBoxInticator)
        
        self.addSubview(label)
    }
    
    func setupConstraints() {
        constrain(radioBoxInticator, self) { box, view in
            box.left == view.left
            box.top >= view.top
            box.bottom <= view.bottom
            box.height == 19 ~ UILayoutPriority(750)
            box.width == box.height
            box.centerY == view.centerY
        }
        constrain(radioBoxInticator, radioInnerBoxInticator) { box, innerBox in
            innerBox.width == box.width - 4
            innerBox.height == box.height - 4
            innerBox.center == box.center
        }
        constrain(label, self) { label, view in
            label.top == view.top
            label.bottom == view.bottom
            label.right == view.right
        }
        constrain(label, radioBoxInticator) { label, box in
            label.left == box.right + 8
        }
    }
    
    @objc func tapAction() {
        self.isSelected = !self.isSelected
        didChangeSelection?(self.isSelected)
    }
}
