//
//  FormPresenter.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

protocol FormPresenterDelegate: NSObjectProtocol {
    func didShowHideCell()
    func didValidateFields(_ isValid: Bool)
}

class FormPresenter: NSObject {
    var model: FormModel
    private var cells: [CellViewModel] {
        return model.cells.filter({ $0.hidden != true })
    }
    private let cellIdentifier = "FormTableViewCell"
    
    weak var delegate: FormPresenterDelegate?
    
    init(with model: FormModel) {
        self.model = model
    }
    
    func getCells(completion: @escaping (() -> ())) {
        self.model.getCells(completion: { success in
            if success {
                completion()
            } else {
                print("can't get cells")
            }
        })
    }
    
    func cell(for index: Int) -> CellViewModel? {
        guard index < self.cells.count else { return nil }
        return self.cells[index]
    }
    
    func selectCell(id: Int, isSelected: Bool) {
        guard let index = model.cells.index(where: { $0.id == id }) else {
            return
        }
        
        model.cells[index].isSelected = isSelected
        if let id = model.cells[index].show, let indexShow = model.cells.index(where: { $0.id == id }) {
            model.cells[indexShow].hidden = !isSelected
        }
        delegate?.didShowHideCell()
    }
    
    func changeValueCell(id: Int, value: String?) {
        guard let index = model.cells.index(where: { $0.id == id }) else {
            return
        }
        
        model.cells[index].value = value
    }
    
    func sendAction() {
        var isValid: Bool = true
        self.cells.forEach({ cell in
            guard let index = model.cells.index(where: { $0.id == cell.id }) else {
                return
            }
            
            if cell.required == true {
                switch cell.typefield {
                case .email?:
                    model.cells[index].isValid = cell.value?.isValidEmail == true
                    if cell.value?.isValidEmail != true {
                        isValid = false
                    }
                case .telNumber?:
                    model.cells[index].isValid = !(cell.value?.isEmpty != false)
                    if cell.value?.isEmpty != false {
                        isValid = false
                    }
                case .text?:
                    model.cells[index].isValid = !(cell.value?.isEmpty != false)
                    if cell.value?.isEmpty != false {
                        isValid = false
                    }
                default:
                    break
                }
            }
        })
        
        delegate?.didValidateFields(isValid)
    }
    
    func registerTableCells(for tableView: UITableView) {
        tableView.register(UINib.init(nibName: "FormTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension FormPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FormTableViewCell
        
        cell.model = cells[indexPath.row]
        cell.didChangeSelection = { isSelected in
            guard let id = self.cells[indexPath.row].id else {
                return
            }
            self.selectCell(id: id, isSelected: isSelected)
        }
        cell.didChangeValue = { value in
            guard let id = self.cells[indexPath.row].id else {
                return
            }
            self.changeValueCell(id: id, value: value)
        }
        cell.sendAction = {
            self.sendAction()
        }
        
        return cell
    }
}
