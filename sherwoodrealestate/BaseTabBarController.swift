//
//  BaseTabBarController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/11/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//


import UIKit

class BaseTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {
    
    // 1 - create Today controller
    // 2 - refactor our repeated logic inside of viewDidLoad
    // 3 - introduce AppSearchController
//    let logoImageView = UIImageView(image: UIImage(named: "jordancohen"), contentMode: .scaleAspectFit)
//    let searchButton = UIButton(title: "Search", titleColor: .black)

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
//        let layout = UICollectionView(frame: frame, collectionViewLayout: )
        let layout = UICollectionViewFlowLayout()
//        let aboutVC = AboutViewController(collectionViewLayout: layout)
        
        viewControllers = [
            createNavController(viewController: HomeViewController(), imageName:"house-7"),
            createNavController(viewController: MapOfListings(), imageName: "pin-map-7"),
            createNavController(viewController: SoldListingsHomeController(), imageName: "house-tick-7"),
            createNavController(viewController: MapOfSoldListings(), imageName: "pin-map-tick-7"),
            
            createNavController(viewController: AboutViewController(collectionViewLayout: layout), imageName: "man-influence")
                        
        ]
        
    }

            
            //        navigationItem.title = "MY NAV BAR"
        
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        let vc = MapOfListings()
//        print(vc.mapView.annotations)
////        print(vc.listing)
//    }
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//
//        let vc = MapOfListings()
//        print(vc)
//
//        print("changed")
//    }
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController.isKind(of: MapOfListings.self) {
//            createNavController(viewController: MapOfListings(), title: "Map", imageName: "apps")
//
//            let vc = MapOfListings()
//            vc.modalPresentationStyle = .formSheet
//        
//            present(MapOfListings(), animated: true, completion: nil)
//          
//            return true
//            
//            
//            
//            
//            
//            
//        }
//        return true
//
//    }
    fileprivate func createNavController(viewController: UIViewController, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return navController
    }
}
