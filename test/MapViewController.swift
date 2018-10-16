//
//  MapViewController.swift
//  test
//
//  Created by sinyilin on 2018/9/28.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    // 1.創建 locationManager
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "出生地"
        
        // 2. 配置 locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 3. 配置 mapView
        map.delegate = self
        map.showsUserLocation = false
        //使用者角度
        map.userTrackingMode = .none
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 1. 還沒有詢問過用戶以獲得權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. 用戶不同意
        else if CLLocationManager.authorizationStatus() == .denied {
            
            let alertc = UIAlertController(title: "Location services were previously denied. Please enable location services for this app in Settings.", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertc.addAction(alertAction)
            self.present(alertc, animated: true, completion: nil)
        }
            // 3. 用戶已經同意
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    func setupData() {
        // 1. 檢查系統是否能夠監視 region
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            // 2.準備 region 會用到的相關屬性
            let title = "Lorrenzillo's"
            let coordinate = CLLocationCoordinate2DMake(24.3039759, 121.0665886)
            let coordinate2 = CLLocationCoordinate2DMake(23.3360183, 120.6380691)
            let coordinate3 = CLLocationCoordinate2DMake(23.7331691, 120.8196428)
            
            //圈圈範圍
            let regionRadius = 1000.0
            
            // 3. 設置 region 的相關屬性
            let region = CLCircularRegion(center:CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude), radius: regionRadius,identifier: title)
            
            locationManager.startMonitoring(for: region)
            
            // 4. 創建大頭釘(annotation)
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "魯夫";
            map.addAnnotation(restaurantAnnotation)
            
            // 5. 繪製一個圓圈圖形（用於表示 region 的範圍）
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            map.add(circle)
            
            let restaurantAnnotation2 = MKPointAnnotation()
            restaurantAnnotation2.coordinate = coordinate2;
            restaurantAnnotation2.title = "娜美";
            map.addAnnotation(restaurantAnnotation2)
            
            let circle2 = MKCircle(center: coordinate2, radius: regionRadius)
            map.add(circle2)
            
            //
            let restaurantAnnotation3 = MKPointAnnotation()
            restaurantAnnotation3.coordinate = coordinate3;
            restaurantAnnotation3.title = "索隆";
            map.addAnnotation(restaurantAnnotation3)
            let circle3 = MKCircle(center: coordinate3, radius: regionRadius)
            map.add(circle3)
        }
        else {
            print("System can't track regions")
        }
    }
    
    // 6. 繪製圓圈
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }

    // 1. 當用戶進入一個 region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let alertc = UIAlertController(title: "進入:\(region.identifier)", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertc.addAction(alertAction)
        self.present(alertc, animated: true, completion: nil)
    }
    
    // 2. 當用戶退出一個 region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let alertc = UIAlertController(title: "離開:\(region.identifier)", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertc.addAction(alertAction)
        self.present(alertc, animated: true, completion: nil)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil
        {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        switch annotation.title
        {
        case "魯夫":
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftIconView.image = UIImage(named: "地圖魯夫")
            annotationView?.leftCalloutAccessoryView = leftIconView
            annotationView?.tintColor = UIColor.orange
            break
        case "索隆":
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftIconView.image = UIImage(named: "地圖索隆")
            annotationView?.leftCalloutAccessoryView = leftIconView
            annotationView?.tintColor = UIColor.orange
            break
        case "娜美":
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftIconView.image = UIImage(named: "地圖娜美")
            annotationView?.leftCalloutAccessoryView = leftIconView
            annotationView?.tintColor = UIColor.orange
            break
        default:
            break
        }
//        print("title:\(String(describing: annotation.title))")
        /*
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .infoLight)
            annotationView = av
        }
 */
//        if let annotationView = annotationView {
//            // Configure your annotation view here
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "地圖頭貼")
//        }
        return annotationView
    }

}
