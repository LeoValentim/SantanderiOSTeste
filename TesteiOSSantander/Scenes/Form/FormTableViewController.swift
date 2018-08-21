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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
    func didValidateFields(_ isValid: Bool) {
        self.tableView.reloadData()
        if isValid {
            self.performSegue(withIdentifier: "sendSegue", sender: self)
        }
    }
    
    func didShowHideCell() {
        self.tableView.reloadData()
    }
}
