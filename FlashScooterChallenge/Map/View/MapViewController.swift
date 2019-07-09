//
//  ViewController.swift
//  FlashScooterChallenge
//
//  Created by Munib Siddiqui on 09/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!{
        
        didSet
        {
            mapView.showsUserLocation = true;
        }
    }
    
    let locationManager = CLLocationManager()
    private var viewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        viewModel.fetchAllVehicles {
            DispatchQueue.main.async {
                self.addAnnotations()
            }
        }
        
    }

}

extension MapViewController {
    
    func addAnnotations() {
        for vehicle in viewModel.vehicles {
            let annotation = MapPin(vehicle: vehicle)
            mapView.addAnnotation(annotation)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let viewModel = annotation as? MapPin else {
            return nil
        }
        let identifier = "scooters"
        let annotationView: MKAnnotationView
        if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = existingView
        } else {
            annotationView = MKAnnotationView(annotation: viewModel, reuseIdentifier: identifier)
        }

        annotationView.image = UIImage(named: "unselected")
        annotationView.canShowCallout = false

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        view.image = UIImage(named: "selected")
        showAnnotationDetail(annotation: view.annotation!)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "unselected")
        remove(asChildViewController: self.children.last!)

    }

    func showAnnotationDetail(annotation:MKAnnotation){

 
        if let vehicleFromAnnotation = annotation as? MapPin {
            
            let scooterDetailViewController:ScooterDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "ScooterDetailViewController") as! ScooterDetailViewController
            
            scooterDetailViewController.loadVehicleDetail(vehicle: vehicleFromAnnotation.vehicle)
            let height = CGFloat(200)
            scooterDetailViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.add(asChildViewController: scooterDetailViewController)
            
            NSLayoutConstraint.activate([
                scooterDetailViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
                scooterDetailViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
                scooterDetailViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -height),
                scooterDetailViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                ])
        }
    }

    private func add(asChildViewController viewController: UIViewController) {

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        viewController.view.layer.add(transition, forKey: nil)

        addChild(viewController)
        self.view.addSubview(viewController.view)

        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        viewController.view.layer.add(transition, forKey: nil)

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()


    }
    
}

