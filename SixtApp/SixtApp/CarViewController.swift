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
import MapKit
import SDWebImage
class CarViewController: UIViewController {
    let carViewModel = CarViewModel()
    let disposeBag = DisposeBag()
    let allCars : [Car] = [Car]()
    @IBOutlet weak var displayModeSegment: UISegmentedControl!
    @IBOutlet weak var carMap: MKMapView!
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
                self?.setupMap()
            }).addDisposableTo(disposeBag)
        
        carViewModel.errorString.asObservable().skip(1)
            .subscribe(onNext: { [weak self] error in
                SVProgressHUD.dismiss()
                self?.showAlertWithMessage(error)
            }).addDisposableTo(disposeBag)
        
       displayModeSegment.rx
        .selectedSegmentIndex
        .asObservable()
        .subscribe(onNext: {[weak self] value in
            value == 1 ? (self?.carMap.isHidden = false) : (self?.carMap.isHidden = true)
        }).addDisposableTo(disposeBag)
        
    }
    func setupMap(){
        let annotations = carViewModel.allCars.value.map{ car -> CarAnnotation in
            let annotation = CarAnnotation(coordinate: CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude), title: car.make + "•" + car.modelName, subtitle: "Transmission : \( car.transmission.lowercased() == "m" ? "Manual" : "Automatic")", url: car.carImageUrl)
            return annotation
        }
        carMap.delegate = self
        carMap.addAnnotations(annotations)
        carMap.showAnnotations(annotations, animated: true)
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
extension CarViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CarAnnotation){
            return nil
        }
        let identifier = "car"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        let carAnnotation = annotation as? CarAnnotation
        anView?.sd_setImage(with: URL(string:(carAnnotation?.imageURL)!), placeholderImage: UIImage(named:"car-placeholder"))
            
        
        return anView
        
    }
}

