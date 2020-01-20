//
//  ViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import SDWebImage
import LBTATools

class HomeViewController: BaseListController, UICollectionViewDelegateFlowLayout {
   
   
    let cellId = "cellId"
    var authToken:ActiveListings.resultsArr!
    var listings: [ActiveListings.listingResults]?
    var photos : [ActiveListings.standardFields.PhotoDictionary]?

    var listingInfo:ActiveListings?
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    let searchButton = UIButton(title: "Search", titleColor: .black)


    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(true)
        activityIndicatorBegin()
        
        collectionView.backgroundColor = UIColor.lightGray
        
        ActiveListings.fetchListing { (listings) in
                
                self.listings = listings.D.Results
                self.collectionView?.reloadData()
                self.activityIndicatorEnd()

             }
        }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor.lightGray
        
        navigationController?.navigationBar.isTranslucent = true
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        setUpNavBar()
    }
    

        func setUpNavBar() {
//            let coverWhiteView = UIView(backgroundColor: .white)
//            view.addSubview(coverWhiteView)
//            coverWhiteView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//            let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
//            coverWhiteView.constrainHeight(safeAreaTop)
            
            
            let width = view.frame.width - 120 - 16 - 60
            let titleView = UIView(backgroundColor: .clear)
            titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
            
            titleView.hstack(logoImageView.withWidth(120), UIView(backgroundColor: .clear).withWidth(width),searchButton.withWidth(60))
            navigationItem.titleView = titleView
        }
    
    
    
    func showListingDetailController(_ listing: ActiveListings.listingResults) {
        let layout = UICollectionViewFlowLayout()
        let listingDetailController = ListingDetailController(collectionViewLayout: layout)
        
        listingDetailController.listing = listing
        print(listing.Id)
        print(listing.StandardFields.Documents?.first?.Id)
//        let newtok = ActiveListings.resultsArr.self
       
        
            
//        self.authToken
//        print(self.authToken)
        
//        let listingIdreq = listing.Id
//        print(listingIdreq)
//        let customAuthString = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(newTok)_expandPhotos,Videos,VirtualTours_filterListAgentId Eq '20160917171150811658000000' And MlsStatus Ne 'Sold' And PropertyClass Ne 'Rental'_limit25_orderby-ListPrice_pagination1"

//        print(customAuthString)
//        let customSig = md5(sessionHash: customAuthString)
//        let customFieldsReq = "http://sparkapi.com/v1/listings/\(listingIdreq)?ApiSig=\(customSig)&AuthToken=\()&_expand=CustomFields"
//       print("THIS IS CustomAuthString \(customAuthString)")
//        print("THIS IS \(customSig)")
//        print("THIS IS \(customFieldsReq)")
//        }
        
        navigationController?.pushViewController(listingDetailController, animated: true)
    }
    // MARK: - Home CollectionViewController
    
    let homeCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        collectionView.backgroundColor = UIColor.clear

        return collectionView
        
    }()
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//         
//         let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
//         
//         let magicalSafeArea: CGFloat = 88
//         print(scrollView.contentOffset.y)
//         let offset = scrollView.contentOffset.y + safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
//         
//         let alpha:CGFloat = 1 - ((scrollView.contentOffset.y + magicalSafeArea) / magicalSafeArea)
//         [logoImageView, searchButton].forEach{$0.alpha = alpha}
//         logoImageView.alpha = alpha
//         navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
//     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.backgroundColor = .white

        cell.listing = listings?[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = listings?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listing = listings?[indexPath.item] {
            showListingDetailController(listing)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

class HomeCell: UICollectionViewCell {
    var listing: ActiveListings.listingResults? {
        didSet {

            imageView.image = nil
            
            imageView.sd_setImage(with: URL(string: listing?.StandardFields.Photos?[0].Uri1600 ?? ""))
            
            if let theAddress = listing?.StandardFields.UnparsedAddress {
                nameLabel.text = theAddress
            }
           
        }
    }

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        backgroundView = .init(backgroundColor: .white)

        setupViews()


    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let nameLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .white, textAlignment: .center)
    let costLabel = UILabel(text: "", font: .systemFont(ofSize: 14), textColor: .white, textAlignment: .center)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)

    func setupViews() {
        backgroundColor = .white
        stack(imageView)
        setupGradientLayer()
        stack(UIView(),nameLabel, costLabel).withMargins(.allSides(8))
          
    }
    let gradientLayer = CAGradientLayer()
    
    func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations =  [0.7,1.2]
        layer.masksToBounds = true
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}
  
//import SwiftUI
//struct HomePreview: PreviewProvider {
//    static var previews: some View  {
//
//            ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        @available(iOS 13.0, *)
//        func makeUIViewController(context: UIViewControllerRepresentableContext<HomePreview.ContainerView>) -> UIViewController {
//            return HomeViewController()
//        }
//
//        @available(iOS 13.0, *)
//        func updateUIViewController(_ uiViewController: HomePreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomePreview.ContainerView>) {
//
//        }
//
//    }
//}
