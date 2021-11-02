//
//  ViewController.swift
//  Swift Practice # 106 Location Tracker
//
//  Created by Dogpa's MBAir M1 on 2021/11/2.
//

import UIKit
import MapKit           //使用MapView函式庫
import CoreLocation     //使用得知位置函式庫

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var hereMapView: MKMapView!  //MapView IBOutlet
    
    var locationManger: CLLocationManager?          //取得使用者位置使用變數

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger = CLLocationManager()                        //指派locationManger取得CLLocationManager()功能
        locationManger?.requestWhenInUseAuthorization()             //尋求使用者是否授權APP得知位置
        locationManger?.delegate = self                             //若是user有移動，可以將透過delegate知道位置顯示
        locationManger?.desiredAccuracy = kCLLocationAccuracyBest   //user位置追蹤精確程度，設置成最精確位置
        locationManger?.activityType = .automotiveNavigation        //設定使用者的位置模式，手機會去依照不同設定做不同的電力控制
        locationManger?.startUpdatingLocation()                     //user有移動會啟動追蹤位置(CLLocationManagerDelegate)
            
        //授權同意後取得使用者位置後指派給hereForNow
        if let hereForNow = locationManger?.location?.coordinate {
            let scaleForX:CLLocationDegrees = 0.01                  //精度緯度設置為0.01
            let scaleForY:CLLocationDegrees = 0.01
            
            //指派span為MKCoordinateSpan後加入精度緯度的比例
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: scaleForY, longitudeDelta: scaleForX)
            //指派regineForNow為MKCoordinateRegion加入現在的user位置，顯示比例為span
            let regineForNow = MKCoordinateRegion(center: hereForNow, span: span)
            hereMapView.setRegion(regineForNow, animated: true)
        }
        
        hereMapView.userTrackingMode = .followWithHeading           //追蹤模式為followWithHeading
        
    }
    //位置有更新要執行項目
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //列印目前地理坐標
        print("目前位置 緯度：\(locations[0].coordinate.latitude) 經度：\(locations[0].coordinate.longitude)")
    }

}

