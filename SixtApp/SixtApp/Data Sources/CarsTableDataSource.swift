//
//  CarsDataSource.swift
//  SixtApp
//
//  Created by Shabir Jan on 11/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit

final class CarsTableDataSource : NSObject, GeneicTableViewDataSource {
    var items : [Car] = []
    weak var tableView : UITableView?
    weak var delegate : UITableViewDelegate?
    
    required init(items: [Car],  tableview : UITableView, delegate : UITableViewDelegate) {
        self.items = items
        self.tableView = tableview
        self.delegate = delegate
        super.init()
        
        tableview.register(cellType: CarCell.self)
        
        self.setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CarCell.self)
        let car = self.items[indexPath.row]
        cell.configureWithCar(car: car)
        return cell
    }
}

class CarTableDelegate : NSObject, UITableViewDelegate {
    
    let delegate : CarsDelegate
    
    init(_ delegate : CarsDelegate) {
        self.delegate = delegate
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CarCell.height()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectCar(at: indexPath)
    }
}
