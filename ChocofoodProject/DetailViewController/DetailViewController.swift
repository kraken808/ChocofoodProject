//
//  DetailViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 20.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import SDWebImage
//class DetailViewController: UIViewController{
//
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    var foods = [Foods]()
//    var foodTypes = [Food_types]()
//    var path: String = ""
//    var imageUrl: String = ""
//
//    init(pk: String, imageUrl: String){
//        path = "/api/extended_restaurants/" + pk
//        print(path)
//        self.imageUrl = imageUrl
//        super.init(nibName: nil, bundle: nil)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//     override func viewDidLoad() {
//          super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = false
//          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//        NetworkManager.shared.request(path: path, method: .get) { (result: Result<CafeMenu,Error>) in
//             switch result{
//                        case .success(let result):
//                                 print(result)
//                                 self.foodTypes.append(contentsOf: result.food_types)
//                                 for food in self.foodTypes{
//                                    self.foods.append(contentsOf: food.foods)
//                                 }
////                                 print("\n-------------")
////                                 print(self.foods)
////                                 print("\n-------------")
//                                DispatchQueue.main.async{
//                                self.collectionView.reloadData()
//                                }
//
//                                case .failure(_):
//                        print(" \n error hetting data! \n")
//
//                }
//        }
//          // Set CollectionView Flow Layout for Header and Items
//          let flowLayout = CollectionViewFlowLayout()
//          flowLayout.scrollDirection = .vertical
//          flowLayout.itemSize = CGSize(width: 100, height: 100)
//          flowLayout.minimumLineSpacing = 1.0
//          flowLayout.minimumInteritemSpacing = 1.0
//          collectionView.collectionViewLayout = flowLayout
//
//         collectionView.delegate = self
//         collectionView.dataSource = self
//          // Register Header
//         collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
//        collectionView.register(UINib(nibName: "MenuSetCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MenuSetCell")
//      }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? CollectionHeaderView {
//                    // Add Image to the Header
//                    headerView.imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
//
//                    return headerView
//                }
//                return UICollectionReusableView()
//
//    }
//}
//
//
//
//extension DetailViewController: UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return foods.count
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSetCell", for: indexPath) as! MenuSetCell
//        cell.bindData(foods: foods[indexPath.row] )
//        return cell
//    }
//
//    // ...
//}
//
//extension DetailViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width, height: 250)
//    }
//}
//enum DragDirection {
//    
//    case Up
//    case Down
//}


//
//var topViewInitialHeight : CGFloat = 200
//
//let topViewFinalHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height + 44 //navigation hieght
//
//let topViewHeightConstraintRange = topViewFinalHeight..<topViewInitialHeight
//
//class DetailViewController: UIViewController, UIScrollViewDelegate {
//  let tabsCount = 5
//    
//    @IBOutlet weak var stickyHeaderView: UIView!
//    @IBOutlet weak var topView: UIView!
//    
//    @IBOutlet weak var tabBar: UICollectionView!
//    
//    @IBOutlet weak var bottomView: UIView!
//    
//    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
//    //MARK:- Programatic UI Properties
//    
//    var pageViewController = UIPageViewController()
//    var selectedTabView = UIView()
//    
//    //MARK:- View Model
//    
//    var pageCollection = PageCollection()
//    
//     var path: String = ""
//        var imageUrl: String = ""
//    
//        init(pk: String, imageUrl: String){
//            path = "/api/extended_restaurants/" + pk
//            print(path)
//            self.imageUrl = imageUrl
//            super.init(nibName: nil, bundle: nil)
//    
//        }
//    
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupCollectionView()
//        setupPagingViewController()
//        populateBottomView()
//        addPanGestureToTopViewAndCollectionView()
//    }
//    
//    func setupCollectionView() {
//           
//           let layout = tabBar.collectionViewLayout as? UICollectionViewFlowLayout
//           layout?.estimatedItemSize = CGSize(width: 100, height: 50)
//           
//           tabBar.register(UINib(nibName: "TabBarViewCell", bundle: nil),
//                                         forCellWithReuseIdentifier: "TabBarViewCell")
//           tabBar.dataSource = self
//           tabBar.delegate = self
//           
//           setupSelectedTabView()
//       }
//       
//       func setupSelectedTabView() {
//           
//           let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
//           label.text = "TAB \(1)"
//           label.sizeToFit()
//           var width = label.intrinsicContentSize.width
//           width = width + 40
//           
//           selectedTabView.frame = CGRect(x: 20, y: 55, width: width, height: 5)
//           selectedTabView.backgroundColor = UIColor(red:0.65, green:0.58, blue:0.94, alpha:1)
//           tabBar.addSubview(selectedTabView)
//       }
//       
//       func setupPagingViewController() {
//           
//           pageViewController = UIPageViewController(transitionStyle: .scroll,
//                                                         navigationOrientation: .horizontal,
//                                                         options: nil)
//           pageViewController.dataSource = self
//           pageViewController.delegate = self
//       }
//    
//    func populateBottomView() {
//    
//    for subTabCount in 0..<tabsCount {
//        
//////        let tabContentVC = MainViewController(path: path, imageUrl: imageUrl)
////        tabContentVC.innerCollectionViewScrollDelegate = self
////       
////        
////        let displayName = "TAB \(subTabCount + 1)"
////        let page = Page(with: displayName, _vc: tabContentVC)
////        pageCollection.pages.append(page)
//    }
//    
//    
//let initialPage = 0
//        
//        pageViewController.setViewControllers([pageCollection.pages[initialPage].vc],
//                                                  direction: .forward,
//                                                  animated: true,
//                                                  completion: nil)
//        
//        
//        addChild(pageViewController)
//        pageViewController.willMove(toParent: self)
//        bottomView.addSubview(pageViewController.view)
//        
//        pinPagingViewControllerToBottomView()
//    }
//    
//    func pinPagingViewControllerToBottomView() {
//        
//        bottomView.translatesAutoresizingMaskIntoConstraints = false
//        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        
//        pageViewController.view.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
//        pageViewController.view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
//        pageViewController.view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
//        pageViewController.view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
//    }
//
//    func addPanGestureToTopViewAndCollectionView() {
//        
//        let topViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
//        
//        stickyHeaderView.isUserInteractionEnabled = true
//        stickyHeaderView.addGestureRecognizer(topViewPanGesture)
//        
//        /* Adding pan gesture to collection view is overriding the collection view scroll.
//         
//        let collViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
//        
//        tabBarCollectionView.isUserInteractionEnabled = true
//        tabBarCollectionView.addGestureRecognizer(collViewPanGesture)
//         
//        */
//    }
//    
//    //MARK:- Action Methods
//    var dragInitialY: CGFloat = 0
//    var dragPreviousY: CGFloat = 0
//    var dragDirection: DragDirection = .Up
//    
//    @objc func topViewMoved(_ gesture: UIPanGestureRecognizer) {
//        
//        var dragYDiff : CGFloat
//        
//        switch gesture.state {
//            
//        case .began:
//            
//            dragInitialY = gesture.location(in: self.view).y
//            dragPreviousY = dragInitialY
//            
//        case .changed:
//            
//            let dragCurrentY = gesture.location(in: self.view).y
//            dragYDiff = dragPreviousY - dragCurrentY
//            dragPreviousY = dragCurrentY
//            dragDirection = dragYDiff < 0 ? .Down : .Up
//            innerCollectionViewDidScroll(withDistance: dragYDiff)
//            
//        case .ended:
//            
//            innerCollectionViewScrollEnded(withScrollDirection: dragDirection)
//            
//        default: return
//        
//        }
//    }
//    
//    //MARK:- UI Laying Out Methods
//    
//    func setBottomPagingView(toPageWithAtIndex index: Int, andNavigationDirection navigationDirection: UIPageViewController.NavigationDirection) {
//        
//        pageViewController.setViewControllers([pageCollection.pages[index].vc],
//                                                  direction: navigationDirection,
//                                                  animated: true,
//                                                  completion: nil)
//    }
//    
//    func scrollSelectedTabView(toIndexPath indexPath: IndexPath, shouldAnimate: Bool = true) {
//        
//        UIView.animate(withDuration: 0.3) {
//            
//            if let cell = self.tabBar.cellForItem(at: indexPath) {
//                
//                self.selectedTabView.frame.size.width = cell.frame.width
//                self.selectedTabView.frame.origin.x = cell.frame.origin.x
//            }
//        }
//    }
//}
//
////MARK:- Collection View Data Source
//
//extension DetailViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return pageCollection.pages.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        if let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarViewCell", for: indexPath) as? TabBarViewCell {
//            
//            tabCell.nameLabel.text = pageCollection.pages[indexPath.row].name
//            return tabCell
//        }
//        
//        return UICollectionViewCell()
//    }
//}
//
////MARK:- Collection View Delegate
//
//extension DetailViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        if indexPath.item == pageCollection.selectedPageIndex {
//            
//            return
//        }
//        
//        var direction: UIPageViewController.NavigationDirection
//        
//        if indexPath.item > pageCollection.selectedPageIndex {
//            
//            direction = .forward
//            
//        } else {
//            
//            direction = .reverse
//        }
//        
//        pageCollection.selectedPageIndex = indexPath.item
//        
//        tabBar.scrollToItem(at: indexPath,
//                                          at: .centeredHorizontally,
//                                          animated: true)
//        
//        scrollSelectedTabView(toIndexPath: indexPath)
//        
//        setBottomPagingView(toPageWithAtIndex: indexPath.item, andNavigationDirection: direction)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}
//
////MARK:- Delegate Method to give the next and previous View Controllers to the Page View Controller
//
//extension DetailViewController: UIPageViewControllerDataSource {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
//            
//            if (1..<pageCollection.pages.count).contains(currentViewControllerIndex) {
//                
//                // go to previous page in array
//                
//                return pageCollection.pages[currentViewControllerIndex - 1].vc
//            }
//        }
//        return nil
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
//            
//            if (0..<(pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
//                
//                // go to next page in array
//                
//                return pageCollection.pages[currentViewControllerIndex + 1].vc
//            }
//        }
//        return nil
//    }
//}
//
////MARK:- Delegate Method to tell Inner View Controller movement inside Page View Controller
////Capture it and change the selection bar position in collection View
//
//extension DetailViewController: UIPageViewControllerDelegate {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        
//        guard completed else { return }
//        
//        guard let currentVC = pageViewController.viewControllers?.first else { return }
//        
//        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
//        
//        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
//        
//        scrollSelectedTabView(toIndexPath: indexPathAtCollectionView)
//        tabBar.scrollToItem(at: indexPathAtCollectionView,
//                                          at: .centeredHorizontally,
//                                          animated: true)
//    }
//}
//
////MARK:- Sticky Header Effect
//
//extension DetailViewController: InnerCollectionViewScrollDelegate {
//    func innerCollectionViewDidScroll(withDistance scrollDistance: CGFloat) {
//            headerHeightConstraint.constant -= scrollDistance
//               
//               /* Don't restrict the downward scroll.
//        
//               if headerHeightConstraint.constant > topViewInitialHeight {
//
//                   headerHeightConstraint.constant = topViewInitialHeight
//               }
//                
//               */
//               
//               if headerHeightConstraint.constant < topViewFinalHeight {
//                   
//                   headerHeightConstraint.constant = topViewFinalHeight
//               }
//    }
//    
//    func innerCollectionViewScrollEnded(withScrollDirection scrollDirection: DragDirection) {
//            
//         let topViewHeight = headerHeightConstraint.constant
//         /*
//                *  Scroll is not restricted.
//                *  So this check might cause the view to get stuck in the header height is greater than initial height.
//        
//               if topViewHeight >= topViewInitialHeight || topViewHeight <= topViewFinalHeight { return }
//                
//               */
//               
//               if topViewHeight <= topViewFinalHeight + 20 {
//                   
//                   scrollToFinalView()
//                   
//               } else if topViewHeight <= topViewInitialHeight - 20 {
//                   
//                   switch scrollDirection {
//                       
//                   case .Down: scrollToInitialView()
//                   case .Up: scrollToFinalView()
//                   
//                   }
//                   
//               } else {
//                   
//                   scrollToInitialView()
//               }
//    }
//    
//    
//    var currentHeaderHeight: CGFloat {
//        
//        return headerHeightConstraint.constant
//    }
//    
//
//    
//  
//    
//    func scrollToInitialView() {
//        
//        let topViewCurrentHeight = stickyHeaderView.frame.height
//        
//        let distanceToBeMoved = abs(topViewCurrentHeight - topViewInitialHeight)
//        
//        var time = distanceToBeMoved / 500
//        
//        if time < 0.25 {
//            
//            time = 0.25
//        }
//        
//        headerHeightConstraint.constant = topViewInitialHeight
//        
//        UIView.animate(withDuration: TimeInterval(time), animations: {
//            
//            self.view.layoutIfNeeded()
//        })
//    }
//    
//    func scrollToFinalView() {
//        
//        let topViewCurrentHeight = stickyHeaderView.frame.height
//        
//        let distanceToBeMoved = abs(topViewCurrentHeight - topViewFinalHeight)
//        
//        var time = distanceToBeMoved / 500
//        
//        if time < 0.25 {
//            
//            time = 0.25
//        }
//        
//        headerHeightConstraint.constant = topViewFinalHeight
//        
//        UIView.animate(withDuration: TimeInterval(time), animations: {
//            
//            self.view.layoutIfNeeded()
//        })
//    }
//}
//
