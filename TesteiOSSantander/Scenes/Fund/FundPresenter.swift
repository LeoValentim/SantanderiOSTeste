//
//  FundPresenter.swift
//  TesteiOSSantander
//
//  Created by Mac on 21/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

protocol FundPresenterDelegate: NSObjectProtocol {
    func didDowloadPress()
}

class FundPresenter: NSObject {
    var model: FundModel
    var screen: Screen? {
        return model.screen
    }
    var infos: [Info] {
        return screen?.info ?? []
    }
    var downInfos: [Info] {
        return screen?.downInfo ?? []
    }

    private let cellIdentifier = "FundTableViewCell"
    
    weak var delegate: FundPresenterDelegate?
    
    init(with model: FundModel) {
        self.model = model
    }
    
    func refreshFund(fundosView: FundosViewControllerProtocol, completion: (() -> Void)? = nil) {
        self.model.getFund(completion: { success in
            if success {
                fundosView.titleFund = self.screen?.title
                fundosView.fundName = self.screen?.fundName
                fundosView.whatIs = self.screen?.whatIs
                fundosView.definition = self.screen?.definition
                fundosView.riskTitle = self.screen?.riskTitle
                fundosView.infoTitle = self.screen?.infoTitle
                fundosView.monthFund = "\(self.screen?.moreInfo?.month?.fund ?? 0)%"
                fundosView.monthCDI = "\(self.screen?.moreInfo?.month?.cdi ?? 0)%"
                fundosView.yearFund = "\(self.screen?.moreInfo?.year?.fund ?? 0)%"
                fundosView.yearCDI = "\(self.screen?.moreInfo?.year?.cdi ?? 0)%"
                fundosView.twelveFund = "\(self.screen?.moreInfo?.the12Months?.fund ?? 0)%"
                fundosView.twelveCDI = "\(self.screen?.moreInfo?.the12Months?.cdi ?? 0)%"
                
                completion?()
            } else {
                print("can't get fund")
            }
        })
    }
    
    func calcHeight(for tableView: UITableView) -> CGFloat {
        return tableView.rowHeight * CGFloat(self.infos.count + self.downInfos.count)
    }
}

extension FundPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.infos.count
        }
        return self.downInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FundTableViewCell
        
        if indexPath.section == 0 {
            cell.info = self.infos[indexPath.row]
            cell.downloadView.isHidden = true
            cell.dataLabel.isHidden = false
        } else {
            cell.info = self.downInfos[indexPath.row]
            cell.downloadView.isHidden = false
            cell.dataLabel.isHidden = true
            cell.downloadTouch = {
                self.delegate?.didDowloadPress()
            }
        }
        
        return cell
    }
}
