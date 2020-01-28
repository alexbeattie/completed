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
    var token: [Service.resultsArr]?
    var listings: [ActiveListings.listingResults]?
    let logoImageView = UIImageView(image: UIImage(named: "nancykoveginas"), contentMode: .scaleAspectFit)
//    let searchButton = UIButton(title: "Search", titleColor: .black)
//    var fields: ActiveListings.customFields.Main?
//    let service = Service()
    override func viewDidAppear(_ animated: Bool) {
//         UIView.animate(withDuration: 1.5) {
        super.viewDidAppear(animated)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorBegin()
//        let thtik = token?.first
//        print(thtik)
        Service.shared.fetchAuthToken { (response) in
            print(response)
            let theTok = self.token
            if let newTok = response.D?.Results?[0] {
                print(newTok)
            }
            self.token = response.D?.Results
            
            
        }
//        print(token)
        
        
        ActiveListings.fetchListing { (listings) in
           
//        listing
           self.listings = listings.D.Results
           self.collectionView?.reloadData()
           self.activityIndicatorEnd()
//           let token = self.token?.AuthToken
//            print(token)
//            let filed = self.fields
//            print(filed)

//            self.authToken = [ActiveListings.listingData.self]
//            print("\(self.authToken)")
        }
//        collectionView.alpha = 0
//        collectionView.visibleCells.anim
        collectionView.backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationController?.navigationBar.isTranslucent = true
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        setUpNavBar()
    }
    

        func setUpNavBar() {
            
            let width = view.frame.width
            let titleView = UIView(backgroundColor: .clear)
            titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
            
            titleView.hstack(logoImageView.withWidth(120))
            navigationItem.titleView = titleView
        }
    
    
//    let token:ActiveListings?
    
    func showListingDetailController(_ listing: ActiveListings.listingResults) {
        let layout = UICollectionViewFlowLayout()
        let listingDetailController = ListingDetailController(collectionViewLayout: layout)
        
        listingDetailController.listing = listing
//        DispatchQueue.main.async {
        
            let thisId = listing.Id
        let auth = token
        print(auth?.first)
//        Service.shared.fetchAuthToken { (tokenResponse) in
//                print("SIMPLE:\(tokenResponse.D.Results[0].AuthToken)")
//                let authToken = tokenResponse.D.Results[0].AuthToken
//                let customFieldsServicePath = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listings/\(thisId)AuthToken\(authToken)_expandCustomFieldsExpandedRaw"
//                let convertedCustomFieldsServicePath = md5(sessionHash: customFieldsServicePath)
//                let customFieldsUrl = "\(GET_URL)listings/\(thisId)?ApiSig=\(convertedCustomFieldsServicePath)&AuthToken=\(authToken)&_expand=CustomFieldsExpandedRaw"
//                guard let newCustomUrl = customFieldsUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
//
//                print(customFieldsServicePath)
//                print(convertedCustomFieldsServicePath)
//                print(customFieldsUrl)
//                let config = URLSessionConfiguration.default
//                let session = URLSession(configuration: config)
//
//                let newCallUrl = URL(string:newCustomUrl)
//                var request = URLRequest(url: newCallUrl!)
//
//
//                request.httpMethod = "GET"
//                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//                request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
//
//               let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//                    guard let data = data else { return }
//                    if let error = error {
//                        print(error)
//                    }
//
//                    do {
//                        let customListing = try? JSONDecoder().decode(ActiveListings.customFields.self, from: data)
//
////                        var ListingLocationsArray = [String]()
//                        let theFields = self.fields?.listingLocationAndPropertyInfo
//                        for aField in (theFields ?? []) {
//                            print(aField)
//                        }
//                        let custom = ActiveListings.customFields.Main.ListingLocationAndPropertyInfo.init()
//                        print(custom)
//
//
//                        print("This is the FUCKING \(customListing)")
////                        let theFieldData
////                        print(theFieldData)
//                    } catch let err {
//                        print(err)
//                    }
//
//                }
//                task.resume()
//
//        }
        
            self.navigationController?.pushViewController(listingDetailController, animated: true)
        
    }
    // MARK: - Home CollectionViewController
    
    let homeCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
        
    }()
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
//        collectionView.fadeIn()
        
        return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let listing = listings?[indexPath.item] {
                   let thisId = listing.Id
//                fetchAuthToken { (tokenResponse) in
//                    print("SIMPLE:\(tokenResponse.D.Results[0].AuthToken)")
//                    let authToken = tokenResponse.D.Results[0].AuthToken
//                    let customFieldsServicePath = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listings/\(thisId)AuthToken\(authToken)_expandCustomFieldsExpandedRaw"
//                    let convertedCustomFieldsServicePath = md5(sessionHash: customFieldsServicePath)
//                    let customFieldsUrl = "\(GET_URL)listings/\(thisId)?ApiSig=\(convertedCustomFieldsServicePath)&AuthToken=\(authToken)&_expand=CustomFieldsExpandedRaw"
//                    guard let newCustomUrl = customFieldsUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
//                    
//                    print(customFieldsServicePath)
//                    print(convertedCustomFieldsServicePath)
//                    print(customFieldsUrl)
//                    
//                    let newCallUrl = URL(string:newCustomUrl)
//                    var request = URLRequest(url: newCallUrl!)
//                    
//                    
//                    request.httpMethod = "GET"
//                    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//                    request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
//                    
//                    URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//                        guard let data = data else { return }
//                        if let error = error {
//                            print(error)
//                        }
//                        
//                        do {
//                            let customListing = try? JSONDecoder().decode([ActiveListings.customFields.Main.GeneralPropertyInformation].self, from: data)
//                            //                    let customFieldsArray = [Dictionary<String,AnyObject>]()
////                            print(customListing)
//                        DispatchQueue.main.async {
//                                                    self.collectionView.reloadData()
//                                                }
//                            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                            print(json)
//                        
//                            let newCustom = customListing
//                            print(newCustom)
//                        } catch let err {
//                            print(err)
//                        }
//                        
//                    }
//                    .resume()
//            }

            showListingDetailController(listing)

//            print(listing)
//            listing.self
            
            
//            print(newTok)
//            let newtok = ActiveListings.resultsArr.self
            
//            print(our)
//            let thisTok = self.authToken
//            self.authToken
//            print(self.authToken)

//            print(newtok[0])
//            let newTok = authToken


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
//            self.fadeOut()
            imageView.image = nil
            
            imageView.sd_setImage(with: URL(string: listing?.StandardFields.Photos?[0].Uri1600 ?? ""))
            
            if let theAddress = listing?.StandardFields.UnparsedAddress {
                nameLabel.text = theAddress.localizedCapitalized
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
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.contentView.layer.cornerRadius
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
//        stack.fade

          
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
