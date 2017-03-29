//
//  ViewController.swift
//  SixtApp
//
//  Created by Shabir Jan on 28/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import UIKit
import SVProgressHUD
import MapKit
import SDWebImage

protocol  CarsDelegate {
    func didSelectCar(at index:IndexPath)
}

class CarViewController: UIViewController {
    
    
    var carManager : CarManager = CarManager()
    var tableDataSource : CarsTableDataSource?
    var tableDelegate : CarTableDelegate?
    
    var cars : [Car] = []
    
    @IBOutlet weak var displayModeSegment: UISegmentedControl!
    @IBOutlet weak var carMap: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCars()
    }
    
    @IBAction func btnRefreshPressed(_ sender: Any) {
        fetchCars()
    }
    @IBAction func segmentValueChanged(_ sender: Any) {
        displayModeSegment.selectedSegmentIndex  == 1 ? setupMap() : (carMap.isHidden = true)
    }
}
//MARK: -Extension for CarViewController for fetching cars and setting up tableview and mapview to show those cars.
extension CarViewController {
    
    //MARK: -Method to fetch cars from Local File or Network
    func fetchCars(){
        SVProgressHUD.show(withStatus: "Loading Cars")
        carManager.fetchAllCars {[weak self] (cars, error) in
            guard error == nil else {
                SVProgressHUD.showError(withStatus: error)
                return
            }
            SVProgressHUD.dismiss()
            guard let cars = cars else {
                SVProgressHUD.showError(withStatus: "No Cars Found")
                return
            }
            self?.cars = cars
            self?.setupTableView()
        }
    }
    
    //MARK: - Method to Setup Tableview Genreic DataSource and Delegate setting
    func setupTableView(){
        tableDelegate = CarTableDelegate(self)
        tableDataSource = CarsTableDataSource(items: self.cars, tableview: tableView, delegate: tableDelegate!)
    }
    
    // MARK: -Method to setup custom annotations on the map to show cars.
    func setupMap(){
        carMap.isHidden = false
        let annotations = self.cars.map{ car -> CarAnnotation in
            let annotation = CarAnnotation(coordinate: CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude), title: car.carTitle, subtitle: car.carTransmision, url: car.carImageUrl)
            return annotation
        }
        carMap.delegate = self
        carMap.addAnnotations(annotations)
        carMap.showAnnotations(annotations, animated: true)
    }
    
}
// MARK: -Extension for Implementation of CarDelgate methods
extension CarViewController : CarsDelegate {
    func didSelectCar(at index: IndexPath) {
        print(self.cars[index.row].modelName)
    }
}
// MARK: -Extension for MapViewDelegate method to customize the annotation for showing Car on the Map
extension CarViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CarAnnotation){
            return nil
        }
        let identifier = "carAnnontation"
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
