//
//  MViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 21.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit


var topViewInitialHeight : CGFloat = 233

let topViewFinalHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height + 44 //navigation hieght

let topViewHeightConstraintRange = topViewFinalHeight..<topViewInitialHeight

class MViewController: UIViewController{
    
    var foods = [Foods]()
        var foodTypes = [Food_types]()
        var path: String = ""
        var imageUrl: String = ""
     fileprivate let HeaderIdentifier = "Header"
    var lastContentOffset: CGFloat = 0
   
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
      
        scrollView.delegate = self
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.clear
        
        imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
   
//                  navigationController?.navigationBar.isTranslucent = true
                

                  // Remove 'Back' text and Title from Navigation Bar
                  self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                  self.title = ""
        
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
            
               viewWithUI.roundCorners(corners: [.topLeft,.topRight], radius: 12)

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
         label.text = "TAB \(1)"
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
               print("----\n")
            let tabContentVC = CollectionViewController(foods: category.foods)
               tabContentVC.innerTableViewScrollDelegate = self
            
            
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
               
               pinPagingViewControllerToBottomView()
           
    }
    
    func pinPagingViewControllerToBottomView() {
          
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
    
    func animateHeader() {
           self.heightContraint.constant = 150
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
               self.view.layoutIfNeeded()
               }, completion: nil)
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

extension MViewController: InnerTableViewScrollDelegate {
    
    var currentHeaderHeight: CGFloat {
        
        return height
    }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat) {
       
        height -= scrollDistance
        
        /* Don't restrict the downward scroll.
 
        if headerViewHeightConstraint.constant > topViewInitialHeight {

            headerViewHeightConstraint.constant = topViewInitialHeight
        }
         
        */
        
        if height < topViewFinalHeight {
            
            height = topViewFinalHeight
        }
    }
    
 
    

}


extension MViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        if scrollView.contentOffset.y < 0 {
            self.heightContraint.constant += abs(scrollView.contentOffset.y)
            incrementColorAlpha(offset: self.heightContraint.constant)
            incrementArticleAlpha(offset: self.heightContraint.constant)
        } else if scrollView.contentOffset.y > 0 && self.heightContraint.constant >= 65 {
            self.heightContraint.constant -= scrollView.contentOffset.y/100
            decrementColorAlpha(offset: scrollView.contentOffset.y)
            decrementArticleAlpha(offset: self.heightContraint.constant)
            
            if self.heightContraint.constant < 65 {
                self.heightContraint.constant = 65
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.heightContraint.constant > 150 {
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if self.heightContraint.constant > 150 {
            animateHeader()
        }
    }
    func decrementColorAlpha(offset: CGFloat) {
          if self.colorView.alpha <= 1 {
              let alphaOffset = (offset/500)/85
              self.colorView.alpha += alphaOffset
          }
      }
      
      
      func decrementArticleAlpha(offset: CGFloat) {
          if self.imageView.alpha >= 0 {
              let alphaOffset = max((offset - 65)/85.0, 0)
              self.imageView.alpha = alphaOffset
          }
      }
      func incrementColorAlpha(offset: CGFloat) {
          if self.colorView.alpha >= 0.6 {
              let alphaOffset = (offset/200)/85
              self.colorView.alpha -= alphaOffset
          }
      }
      func incrementArticleAlpha(offset: CGFloat) {
          if self.imageView.alpha <= 1 {
              let alphaOffset = max((offset - 65)/85, 0)
              self.imageView.alpha = alphaOffset
          }
      }
}
