//
//  FormModels.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation
import UIKit

protocol FormModel {
    typealias GetCellsCompl = (_ success: Bool) -> ()
    var cells: [CellViewModel] { get set }
    
    func getCells(completion: @escaping GetCellsCompl)
}

class FormModelRemote: FormModel {
    var cells: [CellViewModel] = []
    let networkLayer: NetworkLayer
    
    init(with networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func getCells(completion: @escaping FormModel.GetCellsCompl) {
        self.networkLayer.getCells(onSuccess: { [weak self] form in
            guard let cells = form?.cells else {
                completion(false)
                return
            }
            
            self?.cells = cells.map({ return CellViewModel(from: $0) })
            completion(true)
        }, onFailure: { error in
            print("error: \(error)")
            completion(false)
        })
    }
}

struct CellViewModel {
    var id: Int?
    var type: Type?
    var message: String?
    var typefield: TypeField?
    var hidden: Bool?
    var topSpacing: CGFloat?
    var show: Int?
    var required: Bool?
    var isSelected: Bool?
    var isValid: Bool?
    var value: String?
    
    init(from cell: Cell) {
        id = cell.id
        type = cell.type
        message = cell.message
        typefield = cell.typefield
        hidden = cell.hidden
        topSpacing = CGFloat(cell.topSpacing ?? 0)
        show = cell.show
        required = cell.required
        isSelected = false
        value = nil
    }
}
