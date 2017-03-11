//
//  GenericTableViewDataSource.swift
//  SixtApp
//
//  Created by Shabir Jan on 11/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit

protocol GeneicTableViewDataSource : UITableViewDataSource {
    associatedtype T
    var items:[T] { get }
    weak var tableView : UITableView? { get }
    weak var delegate : UITableViewDelegate? { get }
    
    init(items: [T], tableview : UITableView, delegate : UITableViewDelegate)
    func setupTableView()
}

extension GeneicTableViewDataSource {
    func setupTableView(){
        self.tableView?.dataSource = self
        self.tableView?.delegate = self.delegate
        self.tableView?.reloadData()
    }
}
