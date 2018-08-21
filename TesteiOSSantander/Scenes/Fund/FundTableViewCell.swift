//
//  FundTableViewCell.swift
//  TesteiOSSantander
//
//  Created by Mac on 21/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

class FundTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var downloadView: UIView!
    
    var info: Info? {
        didSet {
            nameLabel.text = info?.name
            dataLabel.text = info?.data
        }
    }
    
    var downloadTouch: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        downloadView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(downloadAction)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func downloadAction() {
        downloadTouch?()
    }
}
