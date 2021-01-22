//
//  MainViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 21.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit
protocol InnerCollectionViewScrollDelegate: class {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerCollectionViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerCollectionViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MainViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK:- Scroll Delegate
    
    weak var innerCollectionViewScrollDelegate: InnerCollectionViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    

    
       var foods = [Foods]()
        var foodTypes = [Food_types]()
        var path: String = ""
        var imageUrl: String = ""
    
        init(path: String, imageUrl: String){
            self.path = path
            print(path)
            self.imageUrl = imageUrl
            super.init(nibName: nil, bundle: nil)
    
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                                        self.collectionView.reloadData()
                                        }
        
                                        case .failure(_):
                                print(" \n error hetting data! \n")
        
                        }
                }
        setupCollectionView()
    }
    
    //MARK:- View Setup
    
    func setupCollectionView() {
        
        
        collectionView.register(UINib(nibName: "MenuSetCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuSetCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}


//MARK:- Table View Data Source

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSetCell", for: indexPath) as! MenuSetCell
            cell.bindData(foods: foods[indexPath.row] )
                return cell
    }
    
}

//MARK:- Scroll View Actions

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = innerCollectionViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            /**
             *  Re-size (Shrink) the top view only when the conditions meet:-
             *  1. The current offset of the table view should be greater than the previous offset indicating an upward scroll.
             *  2. The top view's height should be within its minimum height.
             *  3. Optional - Collapse the header view only when the table view's edge is below the above view - This case will occur if you are using Step 2 of the next condition and have a refresh control in the table view.
             */
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                innerCollectionViewScrollDelegate?.innerCollectionViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            /**
             *  Re-size (Expand) the top view only when the conditions meet:-
             *  1. The current offset of the table view should be lesser than the previous offset indicating an downward scroll.
             *  2. Optional - The top view's height should be within its maximum height. Skipping this step will give a bouncy effect. Note that you need to write extra code in the outer view controller to bring back the view to the maximum possible height.
             *  3. Expand the header view only when the table view's edge is below the header view, else the table view should first scroll till it's offset is 0 and only then the header should expand.
             */
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                innerCollectionViewScrollDelegate?.innerCollectionViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            innerCollectionViewScrollDelegate?.innerCollectionViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            innerCollectionViewScrollDelegate?.innerCollectionViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}

