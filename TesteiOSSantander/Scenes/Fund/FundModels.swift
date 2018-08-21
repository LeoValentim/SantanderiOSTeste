//
//  FundModels.swift
//  TesteiOSSantander
//
//  Created by Mac on 21/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation
import UIKit

protocol FundModel {
    typealias GetFundCompl = (_ success: Bool) -> ()
    var screen: Screen? { get set }
    
    func getFund(completion: @escaping GetFundCompl)
}

class FundModelRemote: FundModel {
    var screen: Screen?
    let networkLayer: NetworkLayer
    
    init(with networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func getFund(completion: @escaping FormModel.GetCellsCompl) {
        self.networkLayer.getFund(onSuccess: { [weak self] fund in
            self?.screen = fund?.screen
            completion(true)
            }, onFailure: { error in
                print("error: \(error)")
                completion(false)
        })
    }
}
