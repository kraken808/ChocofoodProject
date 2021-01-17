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
        title = "salam"
        
  collectionView.delegate = self
       collectionView.dataSource = self
     collectionView.register(UINib(nibName: "MenuCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuCell")
      collectionView.register(UINib(nibName: "SmallMenuCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SmallMenuCell")
        
     
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
