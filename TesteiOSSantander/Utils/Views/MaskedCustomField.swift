//
//  MaskedCustomField.swift
//  TesteiOSSantander
//
//  Created by Mac on 22/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import AKMaskField
import Cartography

class MaskedCustomField: AKMaskField {
    
    @IBInspectable var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var borderActiveColor: UIColor?
    @IBInspectable var borderErrorColor: UIColor?
    @IBInspectable var borderCorrectColor: UIColor?
    
    var labelTransforTranslate: CGAffineTransform!
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        label.font = UIFont(name: "DINPro-Regular", size: 16)
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
        self.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        self.font = UIFont(name: "DINPro-Regular", size: 16)
        self.addTarget(self, action: #selector(editingBegin(_:)), for: UIControlEvents.editingDidBegin)
        self.addTarget(self, action: #selector(editingEnd(_:)), for: UIControlEvents.editingDidEnd)
        
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
    
    @objc func editingBegin(_ textField: UITextField) {
        self.label.font = UIFont(name: "DINPro-Regular", size: 11)
    }
    
    @objc func editingEnd(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            self.label.font = UIFont(name: "DINPro-Regular", size: 16)
        }
    }
    
}
