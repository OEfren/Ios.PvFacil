//
//  ViewController.swift
//  PvFacil
//
//  Created by Efren Ordaz on 03/12/23.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var gMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SucursalService().loadData{(items) in
            
            self.gMap.camera = GMSCameraPosition.camera(withLatitude: items[0].sucursalInfo.lat, longitude: items[0].sucursalInfo.lon, zoom: 6.0)
            
            for item in items {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: item.sucursalInfo.lat, longitude: item.sucursalInfo.lon))
                marker.title = item.sucursalInfo.nombre
                marker.map = self.gMap
            }
        }
    }


}

