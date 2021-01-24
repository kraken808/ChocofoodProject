//
//  CollectionViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 24.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
enum DragDirection {
    
    case Up
    case Down
}

protocol InnerTableViewScrollDelegate: class {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    
}

class CollectionViewController: UIViewController{
    var foods = [Foods]()
    @IBOutlet var collectionView: UICollectionView!
    weak var innerTableViewScrollDelegate: InnerTableViewScrollDelegate?
    
    private var dragDirection: DragDirection = .Up
       private var oldContentOffset = CGPoint.zero
    
     init(foods: [Foods]){
        self.foods = foods
           print("\n-------foood------")
                                                 print(self.foods)
                                                 print("\n------food end-------")
            super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = CollectionViewFlowLayout()
                         flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8)
                         
        flowLayout.itemSize = CGSize(width: collectionView.frame.width - 16, height: collectionView.frame.width - 16)
                         collectionView.collectionViewLayout = flowLayout
        setupTableView()

    }
    
    func setupTableView() {
          
        collectionView.register(UINib(nibName: "MenuSetCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuSetCell")
       
        
          collectionView.dataSource = self
          collectionView.delegate = self
          
      }
}

extension CollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSetCell", for: indexPath) as! MenuSetCell
                       cell.bindData(foods: foods[indexPath.row] )
        
                       return cell
    }
    
    
}

extension CollectionViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           
           let delta = scrollView.contentOffset.y - oldContentOffset.y
           
           let topViewCurrentHeightConst = innerTableViewScrollDelegate?.currentHeaderHeight
           
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
                   innerTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
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
                   innerTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                   scrollView.contentOffset.y -= delta
               }
           }
           
           oldContentOffset = scrollView.contentOffset
       }
  
}
