//
//  MViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 21.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit




class MViewController: UIViewController{
    
    var foods = [Foods]()
        var foodTypes = [Food_types]()
        var path: String = ""
        var imageUrl: String = ""
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageViewContainer: UIView!
    
    @IBOutlet weak var viewWithUI: UIView!
    
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    
      init(pk: String, imageUrl: String){
            path = "/api/extended_restaurants/" + pk
            print(path)
            self.imageUrl = imageUrl
            super.init(nibName: nil, bundle: nil)

        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.isHidden = false
        // Make the Navigation Bar background transparent
        
//        imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
//        navigationController?.navigationBar.setBackgroundImage(imageView.image, for: .default)
//        navigationController?.navigationBar.shadowImage = imageView.image
//                  navigationController?.navigationBar.isTranslucent = true
                

                  // Remove 'Back' text and Title from Navigation Bar
                  self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                  self.title = ""
         let flowLayout = CollectionViewFlowLayout()
                  flowLayout.scrollDirection = .vertical
                  flowLayout.itemSize = CGSize(width: 300, height: 300)
                  flowLayout.minimumLineSpacing = 1.0
                  flowLayout.minimumInteritemSpacing = 5
                  bottomCollectionView.collectionViewLayout = flowLayout
                  
        bottomCollectionView.isScrollEnabled = false
        
         NetworkManager.shared.request(path: path, method: .get) { (result: Result<CafeMenu,Error>) in
                     switch result{
                                case .success(let result):
                                         print(result)
                                         self.foodTypes.append(contentsOf: result.food_types)
                                         for food in self.foodTypes{
                                            self.foods.append(contentsOf: food.foods)
                                         }
        //                                 print("\n-------------")
        //                                 print(self.foods)
        //                                 print("\n-------------")
                                        DispatchQueue.main.async{
                                        self.bottomCollectionView.reloadData()
                                        }
        
                                        case .failure(_):
                                print(" \n error hetting data! \n")
        
                        }
                }
       
                 
                 bottomCollectionView.dataSource = self
                 
                  bottomCollectionView.register(UINib(nibName: "MenuSetCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuSetCell")
               viewWithUI.roundCorners(corners: [.topLeft,.topRight], radius: 12)
        scrollView.delegate = self
       
        
    }
  
   
    
}

extension MViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSetCell", for: indexPath) as! MenuSetCell
                cell.bindData(foods: foods[indexPath.row] )
                return cell
    }


}


extension MViewController: UICollectionViewDelegate{

}

extension MViewController: UIScrollViewDelegate{

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

       let height = scrollView.frame.size.height
         let contentYoffset = scrollView.contentOffset.y
        
         let distanceFromBottom = scrollView.contentSize.height - contentYoffset
         if distanceFromBottom < height {
            bottomCollectionView.isScrollEnabled = true
         }
    }
}



