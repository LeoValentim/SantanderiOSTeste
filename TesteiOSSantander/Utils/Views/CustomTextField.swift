//
//  CustomTextField.swift
//  TesteiOSSantander
//
//  Created by Mac on 11/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import Cartography

class CustomTextField: UITextField {
    
    @IBInspectable var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var borderActiveColor: UIColor?
    @IBInspectable var borderErrorColor: UIColor?
    @IBInspectable var borderCorrectColor: UIColor?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var borderBottom: UIView = {
        let view = UIView()
        view.backgroundColor = borderActiveColor
        return view
    }()
    
    var isValid: Bool? {
        didSet {
            if isValid == true {
                borderBottom.backgroundColor = borderCorrectColor
            } else if isValid == false {
                borderBottom.backgroundColor = borderErrorColor
            } else {
                borderBottom.backgroundColor = borderActiveColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
        setupConstraints()
    }
    
    func initViews() {
        label.text = self.labelText
        self.addSubview(label)
        
        borderBottom.backgroundColor = self.borderColor
        self.addSubview(borderBottom)
    }
    
    func setupConstraints() {
        constrain(label, self) { label, view in
            label.left == view.left
            label.top == view.top
        }
        constrain(borderBottom, self) { border, view in
            border.left == view.left
            border.right == view.right
            border.bottom == view.bottom
            border.height == 1
        }
    }
    
    
    
}
