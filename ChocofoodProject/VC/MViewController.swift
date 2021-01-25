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
     fileprivate let HeaderIdentifier = "Header"
    var lastContentOffset: CGFloat = 0
   
    @IBOutlet weak var deliveryFrom: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet var mainContainer: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageViewContainer: UIView!
    
    @IBOutlet weak var viewWithUI: UIView!
    
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    var height = CGFloat(260)
    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    @IBOutlet weak var tabBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomView: UIView!
    
    var pageViewController = UIPageViewController()
    var selectedTabView = UIView()
    var pageCollection = PageCollection()
    var cafename = ""
    
    init(cafeName: String, pk: String, imageUrl: String){
            path = "/api/extended_restaurants/" + pk
            print(path)
            self.imageUrl = imageUrl
        self.cafename = cafeName
            super.init(nibName: nil, bundle: nil)
       
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
//       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//            self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.navigationBar.isTranslucent = true
//            self.navigationController?.view.backgroundColor = UIColor.clear
//            navigationController?.navigationBar.isTranslucent = true
                

                
                  self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                  self.title = ""
        
         
               getData()
               viewWithUI.roundCorners(corners: [.topLeft,.topRight], radius: 12)
               bindData()
    }
    func getData(){
        NetworkManager.shared.request(path: path, method: .get) { (result: Result<CafeMenu,Error>) in
                     switch result{
                                case .success(let result):
                                         print(result)
                                         self.foodTypes.append(contentsOf: result.food_types)
                                         for food in self.foodTypes{
                                            self.foods.append(contentsOf: food.foods)
                                         }
                                        
                                        DispatchQueue.main.async{
                                        self.tabCollectionView.reloadData()
                                            self.setupCollectionView()
                                            self.setupPagingViewController()
                                             self.populateBottomView()
                                        }
        
                                        case .failure(_):
                                print(" \n error hetting data! \n")
        
                        }
                }
    }
    
    func bindData(){
        self.cafeName.text = cafename
        self.deliveryFrom.text = "Доставка от " + cafename + ":"
        imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
    }
    func setupCollectionView() {
         
         let layout = tabCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: 60, height: 30)
         
        tabCollectionView.register(UINib(nibName: "TabBarViewCell", bundle: Bundle.main),
                                       forCellWithReuseIdentifier: "TabBarViewCell")
         tabCollectionView.dataSource = self
         tabCollectionView.delegate = self
         
         setupSelectedTabView()
     }
    func setupSelectedTabView() {
         
         let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
         
         label.sizeToFit()
         var width = label.intrinsicContentSize.width
         width = width + 40
         
         selectedTabView.frame = CGRect(x: 20, y: 55, width: width, height: 5)
         selectedTabView.backgroundColor = UIColor(red:0.65, green:0.58, blue:0.94, alpha:1)
         tabCollectionView.addSubview(selectedTabView)
     }
    
    func setupPagingViewController() {
          
          pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                        navigationOrientation: .vertical,
                                                        options: nil)
          pageViewController.dataSource = self
          pageViewController.delegate = self
      }
    
    func populateBottomView() {
     
        for category in foodTypes {
              
            let tabContentVC = CollectionViewController(foods: category.foods)
               
            
            let displayName = category.title
               let page = Page(with: displayName, _vc: tabContentVC)
               pageCollection.pages.append(page)
           }
        let initialPage = 0
               
               pageViewController.setViewControllers([pageCollection.pages[initialPage].vc],
                                                         direction: .forward,
                                                         animated: true,
                                                         completion: nil)
               
               
               addChild(pageViewController)
               pageViewController.willMove(toParent: self)
               bottomView.addSubview(pageViewController.view)
               
               setConstr()
           
    }
    
    func setConstr() {
          
          bottomView.translatesAutoresizingMaskIntoConstraints = false
          pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
          
          pageViewController.view.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
          pageViewController.view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
          pageViewController.view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
          pageViewController.view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
      }
    
    func setBottomPagingView(toPageWithAtIndex index: Int, andNavigationDirection navigationDirection: UIPageViewController.NavigationDirection) {
           
           pageViewController.setViewControllers([pageCollection.pages[index].vc],
                                                     direction: navigationDirection,
                                                     animated: true,
                                                     completion: nil)
       }
    
    func scrollSelectedTabView(toIndexPath indexPath: IndexPath, shouldAnimate: Bool = true) {
           
           UIView.animate(withDuration: 0.3) {
               
               if let cell = self.tabCollectionView.cellForItem(at: indexPath) {
                   
                   self.selectedTabView.frame.size.width = cell.frame.width
                   self.selectedTabView.frame.origin.x = cell.frame.origin.x
               }
           }
       }
    
}

extension MViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCollection.pages.count

    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarViewCell", for: indexPath) as? TabBarViewCell {
              
              tabCell.nameLabel.text = pageCollection.pages[indexPath.row].name
              return tabCell
          }
          
          return UICollectionViewCell()
    }
   

}


extension MViewController: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      if indexPath.item == pageCollection.selectedPageIndex {
          
          return
      }
      
      var direction: UIPageViewController.NavigationDirection
      
      if indexPath.item > pageCollection.selectedPageIndex {
          
          direction = .forward
          
      } else {
          
          direction = .reverse
      }
      
      pageCollection.selectedPageIndex = indexPath.item
      
      tabCollectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
      
      scrollSelectedTabView(toIndexPath: indexPath)
      
      setBottomPagingView(toPageWithAtIndex: indexPath.item, andNavigationDirection: direction)
  }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension MViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
        
        if (1..<pageCollection.pages.count).contains(currentViewControllerIndex) {
            
            // go to previous page in array
            
            return pageCollection.pages[currentViewControllerIndex - 1].vc
        }
    }
        print("saaaaaaaalam")
    return nil
}
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
                   
                   if (0..<(pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                       
                       // go to next page in array
                       
                       return pageCollection.pages[currentViewControllerIndex + 1].vc
                   }
               }
         print("saaaaaaaalam")
               return nil
    }
}

extension MViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        
        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
        
        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
        
        scrollSelectedTabView(toIndexPath: indexPathAtCollectionView)
        tabCollectionView.scrollToItem(at: indexPathAtCollectionView,
                                          at: .centeredHorizontally,
                                          animated: true)
    }
}




