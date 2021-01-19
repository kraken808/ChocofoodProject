//
//  ViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
       var latitude: Double = 0.0
       var longitude: Double = 0.0
    var activityIndicator=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var cafes = [Cafe]()
    var reuseIdentifier = "cellView"
    private let cafeUrl = "https://api.jsonbin.io/b/5ff1946009f7c73f1b6d134f"
    static let shared = NetworkManager(baseUrl: "https://hermes.chocofood.kz")
    var offset = 0
    let limit = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        ViewController.shared.request(path:"/api/delivery_areas/restaurants/", method: .get, params: ["latitude": 43.236511,"limit":4, "longitude":76.91573,"offset":0]) { (result: Result<[Cafe],Error>) in
                          switch result{
                                case .success(let result):
                                 
                                self.cafes = result
                                self.offset += self.limit
                                            DispatchQueue.main.async{
                                                self.collectionView.reloadData()
                                            }
                                  print(result)
                                case .failure(_):
                                    print("\n \n error hetting data! \n \n")

                                }
                   }
       collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.register(UINib(nibName: "MenuCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuCell")
       collectionView.register(UINib(nibName: "SmallMenuCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SmallMenuCell")
       
   }
    
    
   func setupLocationManager(){
          
          locationManager = CLLocationManager()
          self.locationManager?.delegate = self
          self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
          self.locationManager?.requestWhenInUseAuthorization()
          self.locationManager?.distanceFilter = 100.0
      }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
           //stop location manager
           self.locationManager?.stopUpdatingLocation()
           
           if let currentLocation: CLLocation = locations.last {
               
               //print(currentLocation)
               latitude = currentLocation.coordinate.latitude
               longitude = currentLocation.coordinate.longitude
           
              //print(latitude)
               //print(longitude)
               
               getNearCafes()
           }
           
       }
   
    func getNearCafes(){
     
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  (indexPath.row % 4 == 2 || indexPath.row % 4 == 3){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallMenuCell", for: indexPath) as! SmallMenuCell
                   cell.bindData(data: cafes[indexPath.row])
                   return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.bindData(data: cafes[indexPath.row])
        return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(#function)
    }
   
}

extension ViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.size.width-31
        let height = collectionView.frame.size.height/2.482
        if (indexPath.row % 4 == 2 || indexPath.row % 4 == 3){
            return CGSize(width: (width-33)/2, height: (height+19)/2)
        }else{
            return CGSize(width: width, height: height)
        }

        return CGSize.zero
    }
 

}

extension ViewController: UIScrollViewDelegate{
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let position = scrollView.contentOffset.y
         
         if position > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
             
             // fetch more data
            ViewController.shared.request(path:"/api/delivery_areas/restaurants/", method: .get, params: ["latitude": 43.236511,"limit":4, "longitude":76.91573, "offset":offset]) { (result: Result<[Cafe],Error>) in
                                 switch result{
                                       case .success(let result):
                                        
                                        self.cafes.append(contentsOf: result)
                                                   DispatchQueue.main.async{
                                                       self.collectionView.reloadData()
                                                   }
                                         print(result)
                                       case .failure(_):
                                           print("\n \n error hetting data! \n \n")

                                       }
                          }
            offset += limit
             
         }
     }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
       
    }
    
}
