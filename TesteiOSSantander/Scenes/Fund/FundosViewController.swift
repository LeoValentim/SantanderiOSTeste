//
//  FundosViewController.swift
//  TesteiOSSantander
//
//  Created by Mac on 20/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import SafariServices
import Cartography

protocol FundosViewControllerProtocol: NSObjectProtocol {
    var titleFund: String? { get set }
    var fundName: String? { get set }
    var whatIs: String? { get set }
    var definition: String? { get set }
    var riskTitle: String? { get set }
    var infoTitle: String? { get set }
    var monthFund: String? { get set }
    var monthCDI: String? { get set }
    var yearFund: String? { get set }
    var yearCDI: String? { get set }
    var twelveFund: String? { get set }
    var twelveCDI: String? { get set }
}

class FundosViewController: UIViewController, FundPresenterDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fundNameLabel: UILabel!
    @IBOutlet weak var whatIsLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var riskTitleLabel: UILabel!
    @IBOutlet weak var riskStackView: UIStackView!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var monthFundLabel: UILabel!
    @IBOutlet weak var monthCDILabel: UILabel!
    @IBOutlet weak var yearFundLabel: UILabel!
    @IBOutlet weak var yearCDILabel: UILabel!
    @IBOutlet weak var twelveFundLabel: UILabel!
    @IBOutlet weak var twelveCDILabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var invistButton: UIButton!
    
    lazy var arrowImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 13))
        image.image = #imageLiteral(resourceName: "Seta")
        return image
    }()
    var arrowConstraint: ConstraintGroup?
    
    var presenter: FundPresenter! = FundPresenter(with: FundModelRemote(with: APILayer()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        presenter.delegate = self
        tableView.dataSource = presenter
        presenter.refreshFund(fundosView: self) {
            self.tableViewHeightConstraint.constant = self.presenter.calcHeight(for: self.tableView)
            self.tableView.reloadData()
            self.view.layoutIfNeeded()
            
            if let risk = self.presenter.screen?.risk {
                let riskView = self.riskStackView.arrangedSubviews[risk - 1]
                self.riskStackView.arrangedSubviews.forEach({ $0.transform = .identity })
                riskView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
                
                let point = riskView.convert(riskView.center, to: self.contentView)
                self.arrowImage.isHidden = false
                self.arrowImage.frame.origin = point
            }
        }
        
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        arrowImage.isHidden = true
        self.contentView.addSubview(arrowImage)
        
        invistButton.layer.cornerRadius = 25
        invistButton.layer.masksToBounds = true
        invistButton.setBackgroundImage( UIImage(color: #colorLiteral(red: 0.89276582, green: 0.1277235746, blue: 0, alpha: 1), size: invistButton.frame.size), for: .normal)
        invistButton.setBackgroundImage( UIImage(color: #colorLiteral(red: 0.944691956, green: 0.5485198498, blue: 0.535849154, alpha: 1), size: invistButton.frame.size), for: .highlighted)
    }
    
    func didDowloadPress() {
        let urlString = "https://www.google.com/"
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            
            present(vc, animated: true)
        }
    }
}

extension FundosViewController: FundosViewControllerProtocol {
    
    var titleFund: String? {
        get { return titleLabel.text }
        set {
            titleLabel.text = newValue
        }
    }
    var fundName: String? {
        get { return fundNameLabel.text }
        set {
            fundNameLabel.text = newValue
        }
    }
    var whatIs: String? {
        get { return whatIsLabel.text }
        set {
            whatIsLabel.text = newValue
        }
    }
    var definition: String? {
        get { return definitionLabel.text }
        set {
            definitionLabel.text = newValue
        }
    }
    var riskTitle: String? {
        get { return riskTitleLabel.text }
        set {
            riskTitleLabel.text = newValue
        }
    }
    var infoTitle: String? {
        get { return infoTitleLabel.text }
        set {
            infoTitleLabel.text = newValue
        }
    }
    var monthFund: String? {
        get { return monthFundLabel.text }
        set {
            monthFundLabel.text = newValue
        }
    }
    var monthCDI: String? {
        get { return monthCDILabel.text }
        set {
            monthCDILabel.text = newValue
        }
    }
    var yearFund: String? {
        get { return yearFundLabel.text }
        set {
            yearFundLabel.text = newValue
        }
    }
    var yearCDI: String? {
        get { return yearCDILabel.text }
        set {
            yearCDILabel.text = newValue
        }
    }
    var twelveFund: String? {
        get { return twelveFundLabel.text }
        set {
            twelveFundLabel.text = newValue
        }
    }
    var twelveCDI: String? {
        get { return twelveCDILabel.text }
        set {
            twelveCDILabel.text = newValue
        }
    }
}
