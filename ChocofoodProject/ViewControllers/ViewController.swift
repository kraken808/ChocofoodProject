//
//  ViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cafes = [Cafe]()
    var reuseIdentifier = "cellView"
    private let cafeUrl = "https://api.jsonbin.io/b/5ff1946009f7c73f1b6d134f"
    static let shared = NetworkManager(baseUrl: "https://api.jsonbin.io")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
     collectionView.register(UINib(nibName: "MenuCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuCell")
        
      
        ViewController.shared.request(path:"/b/5ff1946009f7c73f1b6d134f", method: .get, params: ["id": 12, "test": "salam"]) { (result: Result<[Cafe],Error>) in
               switch result{
                     case .success(let result):
                        print(result)
                     self.cafes = result
                                 DispatchQueue.main.async{
                                     self.collectionView.reloadData()
                                 }
                       print(result)
                     case .failure(_):
                         print("\n \n error hetting data! \n \n")

                     }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.bindData(data: cafes[indexPath.row])
        return cell
    }
    
    
}

//extension ViewController: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        print(#function)
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 203
//    }
//   
//}

//extension ViewController: UICollectionViewDelegateFlowLayout{
//
//// func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////      let width = (collectionView.frame.size.width-30)
////    print("heaight: \(width)")
////    print("width: \(width)")
////       return CGSize(width: width, height: width)
////   }
//
//   //---------------------------------------------------------------------------------------------------------------------------------------------
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//       return 1
//   }
//
//   //---------------------------------------------------------------------------------------------------------------------------------------------
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//       return 1
//   }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 40, left: 15, bottom: 26, right: 16)
//    }
//}
