//
//  CarViewModel.swift
//  SixtApp
//
//  Created by Shabir Jan on 01/03/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import RxSwift

class CarViewModel {
    let carManager: CarManager
    let allCars: Variable<[Car]> = Variable([])
    var errorString  = Variable<String?>("")

    init(manager: CarManager) {
        self.carManager = manager
        self.carManager.fetchAllCars { [weak self](cars, error) in
            guard error == nil else{
                self?.errorString.value = error!
                return
            }
            self?.allCars.value = cars!
        }
    }
}
