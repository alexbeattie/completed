//
//  ViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import SDWebImage

class SoldListingsHomeController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let footerId = "footerId"

    var authToken:SoldListings.resultsArr!
    var listings: [SoldListings.listingResults]?
    var photos : [SoldListings.standardFields.PhotoDictionary]?
    
    var listingInfo:SoldListings?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicatorBegin()
        collectionView.backgroundColor = .white

//        view.addSubview(activityIndicator)
//        activityIndicator.frame = view.bounds
//        activityIndicator.startAnimating()

        
        
//        homeVC?.activityIndicator
        SoldListings.fetchListing { (listings) in
             self.listings = listings.D.Results
             self.collectionView?.reloadData()
            self.activityIndicatorEnd()

//            self.activityIndicator.stopAnimating()
//            self.activityIndicator.hidesWhenStopped = true

         }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        self.activityIndicatorEnd()
        navigationController?.navigationBar.isTranslucent = true
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.compactAppearance = .none
        } else {
            // Fallback on earlier versions
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.title = "Previously Sold"
//        navigationController?.navigationBar.barTintColor = .clear
//        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(SoldLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)

        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(SoldListingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self

    }

    func showSoldListingDetailController(_ listing: SoldListings.listingResults) {
        let layout = UICollectionViewFlowLayout()
        let soldListingDetailController = SoldListingDetailController(collectionViewLayout: layout)
        
        soldListingDetailController.listing = listing
        print(listing.Id)
        
        let newtok = SoldListings.resultsArr.self
        
        print(newtok)

//        Service.shared.fetchAuthToken { (tokenResponse) in
//            let newTok = tokenResponse.D.Results[0].AuthToken
//            print("SIMPLE:\(tokenResponse.D.Results[0].AuthToken)")
//            let listingIdreq = listing.Id
//            print(listingIdreq)
////            let customAuthString = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listings/\(listingIdreq)AuthToken\(newTok)_expandCustomFields,Photos,Videos,VirtualTours_limit1"
//
//            var listingsString = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listings/"
//            var id = ("\(listingIdreq)" + "\(newTok)")
//            print(id)
//            var newFilters = "_expandCustomFields_limit1"
//            
//            let customFieldsPath = "\("\(listingsString)" + "\(id)" + "\(newFilters)")"
//            print(customFieldsPath)
////            print(customAuthString)
//            let customSig = md5(sessionHash: customFieldsPath)
//
//            let customFieldsReq = "http://sparkapi.com/v1/listings/\(listingIdreq)?ApiSig=\(customSig)&AuthToken=\(newTok)&_expand=CustomFields&_limit=1"
////            "http://sparkapi.com/v1/listings/\(listingIdreq)?ApiSig=\(customSig)&AuthToken=\(newTok)&_expand=CustomFields,Photos,Videos,VirtualTours"
////                   print("THIS IS CustomAuthString \(customAuthString)")
////                    print("THIS IS \(customSig)")
////                    print("THIS IS \(customFieldsReq)")
//           
//            print(customFieldsReq)
//            let baseUrl = URL(string: customFieldsReq)!
//            print(baseUrl)
//            var request = URLRequest(url:baseUrl)
//            print(request)
//            request.httpMethod = "GET"
//            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//            request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
//                            
////            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
////                guard let data = data else { return }
//////                        print(data)
////                if let error = error {
////                    print(error)
////                }
////                do {
////                    let newListing = try JSONDecoder().decode(listingData.self, from: data)
////                }
//
//        }
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
        
        
        navigationController?.pushViewController(soldListingDetailController, animated: true)
    }
    // MARK: - Home CollectionViewController
    
    let homeCollectionView:UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
        
    }()
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoldListingsCell
        
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
            showSoldListingDetailController(listing)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
//        return footer
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return .init(width: view.frame.width, height: 100)
//    }

}

class SoldListingsCell: UICollectionViewCell {
    var listing: SoldListings.listingResults? {
        didSet {
            
            imageView.image = nil
            
            imageView.sd_setImage(with: URL(string: listing?.StandardFields.Photos?[0].Uri1600 ?? ""))
            
            if let theAddress = listing?.StandardFields.UnparsedAddress {
                nameLabel.text = theAddress
            }
            if let listPrice = listing?.StandardFields.ListPrice {
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                let subTitleCost = "$\(nf.string(from: NSNumber(value:(UInt64(listPrice) )))!)"
                costLabel.text = subTitleCost
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
            gradientLayer.locations = [0.7,1.2]
            layer.masksToBounds = true
            layer.addSublayer(gradientLayer)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }
    }


