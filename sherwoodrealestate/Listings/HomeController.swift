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
    var token: ActiveListings.resultsArr?
//    var otherTok: [ActiveListings.resultsArr]<Array>
    var listings: [ActiveListings.listingResults]?
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
//    let searchButton = UIButton(title: "Search", titleColor: .black)
//    var fields: ActiveListings.customFields.Main?
//    let service = Service()
    override func viewDidAppear(_ animated: Bool) {
//         UIView.animate(withDuration: 1.5) {
        super.viewDidAppear(animated)

//               print(name)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorBegin()
//        let thtik = token?.AuthToken
//        print("AHHHHHHHHHH \(thtik)")
//        ActiveListings.fetchAuthToken { (response) in
//            self.token = response.D.Results
//
//        }
//        Service.shared.fetchAuthToken { (response) in
//            print(response)
////            let theTok = self.token
////            if let newTok = response.D.Results[0].AuthToken {
////                print(newTok)
////            }
//            self.token = response.D.Results
//
//
//        }
//        print(token)
        
        
        ActiveListings.fetchListing { (listings) in
           
//        listing
           self.listings = listings.D.Results
           self.collectionView?.reloadData()
           self.activityIndicatorEnd()
//            var tokenNew = self.token?.AuthToken
//            self.token?.AuthToken = "\(String(describing: self.token?.AuthToken))"
//            tokenNew?.append(<#T##other: String##String#>)
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
//        let authToken = UserDefaults.standard.string(forKey: "AuthToken")
        let thisId = listing.Id

       
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 2
      }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("XXXXXXXXX did select")
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
//            self.fadeOut()
            imageView.image = nil
            
            imageView.sd_setImage(with: URL(string: listing?.StandardFields.Photos?[0].Uri800 ?? ""))
            
            if let theAddress = listing?.StandardFields.UnparsedFirstLineAddress {
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
    let nameLabel = UILabel(text: "", font: UIFont(name: "Avenir Heavy", size: 16), textColor: .white, textAlignment: .center)
    let costLabel = UILabel(text: "", font: UIFont(name: "Avenir Heavy", size: 14), textColor: .white, textAlignment: .center)
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
        gradientLayer.locations =  [0.7,1.1]
        layer.masksToBounds = true
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func welcomeTask(with url: URL, completionHandler: @escaping (Main?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
