//
//  ScooterDetailViewController.swift
//  FlashScooterChallenge
//
//  Created by Munib Siddiqui on 08/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import UIKit

class ScooterDetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        print("SecondViewController Will Appear")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("SecondViewController Will Disappear")
    }
    
    
    func loadVehicleDetail(vehicle:Vehicle) {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()

        }

        NetworkManager.sharedInstance.getAllVehicalById(vehicleId: vehicle.id, onSuccess: { (vehicle) in
           
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                self.populateVehicleInfor(vehicle: vehicle)
            }
            
        }) { (error) in
            
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
    
    func populateVehicleInfor(vehicle:Vehicle) {
        
        self.nameLabel.text = "#"+vehicle.name
        let priceValue = vehicle.currency + String(vehicle.price) + " + " + vehicle.currency + "0.2" + "/" + priceValuePerInterval(priceTime: vehicle.priceTime)
        self.priceLabel.text = priceValue
        self.batteryLevelLabel.text = String(vehicle.batteryLevel) + "%"
        
        self.containerView.alpha = 1
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        // Log if a view controller is being deinited
        print(" SecondViewController \nDeinit: \(self.description)\n")
    }
    
    func priceValuePerInterval(priceTime:Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        
        let formattedString = formatter.string(from: TimeInterval(priceTime))!
        return formattedString
    }
}
