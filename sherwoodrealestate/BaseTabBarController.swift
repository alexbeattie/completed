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
    let logoImageView = UIImageView(image: UIImage(named: "jordancohen"), contentMode: .scaleAspectFit)
    let searchButton = UIButton(title: "Search", titleColor: .black)

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        

        viewControllers = [
            createNavController(viewController: HomeViewController(), title: "", imageName:"constructin"),

//            createNavController(viewController: SoldViewController(), title: "", imageName: "apps"),
            createNavController(viewController: MapOfListings(), title: "", imageName: "activemap"),
            createNavController(viewController: SoldListingsHomeController(), title: "Sold", imageName: "apps"),
            createNavController(viewController: MapOfSoldListings(), title: "Map of Sold", imageName: "apps")
            

            
//            createNavController(viewController: AllListingsMapVC(), title: "Map", imageName: "apps"),


//            createNavController(viewController: AppSearchController(), title: "Search", imageName: "search"),
//            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            
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
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
//        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
//        viewController.view.backgroundColor = .orange
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return navController
    }
}
