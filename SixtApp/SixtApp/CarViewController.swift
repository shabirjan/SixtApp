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
    var carViewModel : CarViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var displayModeSegment: UISegmentedControl!
    @IBOutlet weak var carMap: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show(withStatus: "Loading Cars")
        carViewModel = CarViewModel(manager: CarManager())
        setupBindings()
    }
}
//MARK:Extension for MapViewDelegate method to customize the annotation for showing Car on the Map
extension CarViewController : MKMapViewDelegate {
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

        let imageview  = UIImageView()
        imageview.download(image: (carAnnotation?.imageURL)!)
        
        var rect = imageview.frame
        rect.size.width = 100
        rect.size.height = 60
        imageview.frame = rect
        anView?.addSubview(imageview)
        anView?.frame = rect
        
        return anView
    }
}

//MARK:General Extension of the CarViewController to seperate logic from actual controller for setting up bindings 
extension CarViewController {
    //MARK:Method responsible for setting up bindings for showing data into tableview and map.
    func setupBindings(){
        
        //MARK:Using ViewModel AllCars as Observable so whenever new items are added in that array this Observable will be called to setup Map and TableView to show the data
        carViewModel.allCars.asObservable().skip(1)
            .subscribe(onNext: {[weak self] _ in
                SVProgressHUD.dismiss()
                self?.setupCellConfiguration()
                self?.setupMap()
            }).addDisposableTo(disposeBag)
        
        //MARK:Using ViewModel Error String as Observable so whenever there is change in errostring this Observable will be called to show the error message to user
        carViewModel.errorString.asObservable().skip(1)
            .subscribe(onNext: { [weak self] error in
                SVProgressHUD.dismiss()
                self?.showAlertWithMessage(error)
            }).addDisposableTo(disposeBag)
        
        
        //MARK:Observable for UISegment Control to observe change in the selection of Segments and show appropriate view to user based on selection
        displayModeSegment.rx
            .selectedSegmentIndex
            .asObservable()
            .subscribe(onNext: {[weak self] value in
                value == 1 ? (self?.carMap.isHidden = false) : (self?.carMap.isHidden = true)
            }).addDisposableTo(disposeBag)
        
    }
    //MARK:Method to setup custom annotations on the map to show cars.
    func setupMap(){
        let annotations = carViewModel.allCars.value.map{ car -> CarAnnotation in
            let annotation = CarAnnotation(coordinate: CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude), title: car.make + "•" + car.modelName, subtitle: "Transmission : \( car.transmission.lowercased() == "m" ? CarTransmissionType.manual : CarTransmissionType.automatic)", url: car.carImageUrl)
            return annotation
        }
        carMap.delegate = self
        carMap.addAnnotations(annotations)
        carMap.showAnnotations(annotations, animated: true)
    }
    
    //MARK:Method to setup Tableview using RxCocoa way
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

