//
//  ViewController.swift
//  mYTRAVEL
//
//  Created by Salih KIR on 14.04.2022.
//

import UIKit
import MapKit
class ViewController: UIViewController , MKMapViewDelegate{
    @IBOutlet weak var mapVC: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVC.delegate = self
        
    }


}

