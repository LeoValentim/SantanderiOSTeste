//
//  FormTableViewCell.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var radioButton: RadioButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    var didChangeSelection: ((Bool) -> Void)?
    var didChangeValue: ((String?) -> Void)?
    var sendAction: (() -> Void)?
    
    var model: CellViewModel? {
        didSet {
            topConstraint.constant = model?.topSpacing ?? 0
            
            radioButton.isHidden = true
            field.isHidden = true
            textField.isHidden = true
            sendButton.isHidden = true
            
            switch model?.type {
            case .checkbox?:
                radioButton.isHidden = false
                radioButton.labelText = model?.message
                radioButton.isSelected = model?.isSelected ?? false
                radioButton.didChangeSelection = { isSelected in
                    self.didChangeSelection?(isSelected)
                }
            case .field?:
                textField.isHidden = false
                textField.text = model?.value
                textField.labelText = model?.message
                textField.isValid = model?.isValid
                switch model?.typefield {
                case .email?:
                    textField.keyboardType = .emailAddress
                    break
                case .telNumber?:
                    textField.keyboardType = .phonePad
                case .text?:
                    textField.keyboardType = .asciiCapable
                default:
                    break
                }
            case .text?:
                field.isHidden = false
                field?.text = model?.message
            case .send?:
                sendButton.isHidden = false
                sendButton.setTitle(model?.message ?? "", for: .normal)
            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        
        sendButton.layer.cornerRadius = 25
        sendButton.layer.masksToBounds = true
        sendButton.setBackgroundImage( UIImage(color: #colorLiteral(red: 1, green: 0.2251740098, blue: 0.1551215351, alpha: 1), size: sendButton.frame.size), for: UIControlState.normal)
        sendButton.setBackgroundImage( UIImage(color: #colorLiteral(red: 0.944691956, green: 0.5485198498, blue: 0.535849154, alpha: 1), size: sendButton.frame.size), for: UIControlState.highlighted)
        sendButton.setBackgroundImage( UIImage(color: #colorLiteral(red: 0.944691956, green: 0.5485198498, blue: 0.535849154, alpha: 1), size: sendButton.frame.size), for: UIControlState.selected)
        sendButton.addTarget(self, action: #selector(self.sendButtonAction), for: .touchUpInside)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func sendButtonAction() {
        self.sendAction?()
    }
}

extension FormTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            didChangeValue?(updatedText)
        }
        return true
    }
}
