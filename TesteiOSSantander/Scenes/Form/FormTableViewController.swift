//
//  FormTableViewController.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

class FormTableViewController: UITableViewController {
    
    var presenter: FormPresenter! = FormPresenter(with: FormModelRemote.init(with: APILayer()))
    var cells: [Cell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        tableView.dataSource = presenter
        presenter.registerTableCells(for: tableView)
        presenter.getCells {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FormTableViewController: FormPresenterDelegate {
    func didValidateFields() {
        self.tableView.reloadData()
    }
    
    func didShowHideCell() {
        self.tableView.reloadData()
    }
}
