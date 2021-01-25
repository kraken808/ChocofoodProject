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
    var collectionLayout = UICollectionViewFlowLayout()
    var cafes = [Cafe]()
    var reuseIdentifier = "cellView"

    
    var offset = 0
    let limit = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//       self.navigationController?.navigationBar.shadowImage = UIImage()
//       self.navigationController?.navigationBar.isTranslucent = true
//       self.navigationController?.view.backgroundColor = UIColor.clear
//        title = "salam"
        
          
       
        setupLocationManager()
        setupCollectionView()
        loadMoreData()
   }
    
    func setupCollectionView(){
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
           //stop location manager
           self.locationManager?.stopUpdatingLocation()
           
           if let currentLocation: CLLocation = locations.last {
               
               //print(currentLocation)
               latitude = currentLocation.coordinate.latitude
               longitude = currentLocation.coordinate.longitude
           
              //print(latitude)
               //print(longitude)
           }
           
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
                   cell.backgroundColor = .white
            cell.layerSetup()
                   return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.bindData(data: cafes[indexPath.row])
            cell.layerSetup()
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == cafes.count - 1 {  //numberofitem count
                loadMoreData()
            }
    }
    func loadMoreData(){
        NetworkManager.shared.request(path:"/api/delivery_areas/restaurants/", method: .get, params: ["latitude": 43.236511,"limit":4, "longitude":76.91573, "offset":offset]) { (result: Result<[Cafe],Error>) in
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

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        let menuViewController = MViewController(cafeName: cafes[indexPath.row].restaurant.title,pk: cafes[indexPath.row].restaurant.pk, imageUrl: cafes[indexPath.row].restaurant.image)
        navigationController?.pushViewController(menuViewController, animated: true)
        
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
    
//      func scrollViewDidScroll(_ scrollView: UIScrollView) {
//         let position = scrollView.contentOffset.y
//
//         if position > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
//
//
//
//             // fetch more data
//
//
//         }
//     }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        collectionView.frame = view.bounds
//
//    }
   
      
  
    
}
