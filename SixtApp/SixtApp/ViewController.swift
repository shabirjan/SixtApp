//
//  ViewController.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
class ViewController: UIViewController {
    let carViewModel = CarViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        SVProgressHUD.show(withStatus: "Loading Cars")
        carViewModel.loadAllCars()
    }
    func setupBindings(){
        carViewModel.allCars.asObservable().skip(1)
            .subscribe(onNext: {[weak self] _ in
                SVProgressHUD.dismiss()
                self?.setupCellConfiguration()
            }).addDisposableTo(disposeBag)
        
        carViewModel.errorString.asObservable().skip(1)
            .subscribe(onNext: { [weak self] error in
                SVProgressHUD.dismiss()
                self?.showAlertWithMessage(error)
            }).addDisposableTo(disposeBag)
    }
    
    func setupCellConfiguration(){
        let allCars = Observable.just(carViewModel.allCars.value)
        allCars
            .bindTo(tableView
                .rx
                .items(cellIdentifier: CarCell.Identifier, cellType: CarCell.self)){
                    _,car,cell in
                    cell.configureWithCar(car: car)
            }
            .addDisposableTo(disposeBag)
        
    }
}

