//
//  ListingDetailController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MapKit
import CoreLocation
import SwiftUI
import MessageUI
import SDWebImage

class ListingDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, UIActivityItemSource {
    
    
    
    let cellId = "cellId"
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    let mapId = "mapId"
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
//    let thisTok: ActiveListings! = nil
    var mapView:MKMapView!
    let pin = MKPointAnnotation()
    var region: MKCoordinateRegion!
    let locationManager = CLLocationManager()
//    var authToken:[resultsArr]?
//    var expires:[resultsArr]?
//    var resourceId:[ActiveListings.resultsArr]?
//    let brs:[ActiveListings.resultsArr]? = nil
    //let logoImageView = UIImageView(image: UIImage(named: "jordancohen"), contentMode: .scaleAspectFit)
//    let searchButton = UIButton(title: "Search", titleColor: .black)
//
    var otherListings = [ActiveListings]()
    
//    var custom: ActiveListings.customFields.Main? {
//        didSet {
//            if let info = custom?.listingLocationAndPropertyInfo {
//                print(info)
//            }
//        }
//    }

    var listing: ActiveListings.listingResults?
//    {
//        didSet {
//            
//            if listing?.StandardFields.Photos != nil {
//                return
//            }
//            if listing?.StandardFields.VirtualTours != nil {
//                return
//            }
//            if listing?.StandardFields.Videos != nil {
//                return
//            }
//            if listing?.StandardFields.Documents != nil {
//               return
//            }
////            if listing?.CustomFields?.CustomFieldsObjs != nil {
////                         return
////            }
////            if let listPrice = listing?.StandardFields.ListPrice {
////                let numberFormatter = NumberFormatter()
////                numberFormatter.numberStyle = .decimal
////
////                let subtitle = "$\(numberFormatter.string(from: NSNumber(value:(UInt64(listPrice) )))!)"
////                pin.subtitle = subtitle
////            }
//        }
//    }

       
//    var theToken: ActiveListings.resultsArr?
//        didSet {
//
//            if theToken?.AuthToken != nil {
//                return
//            }
//            print(theToken)
//        }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
//        collectionView?.register(ListingInfoCell.self, forCellWithReuseIdentifier: titleId)
//        print(listing?.StandardFields.Documents?.index(after: 0))
//        let atok = thisTok?.emptyTok
//        print(atok)
//        let name = UserDefaults.standard.string(forKey: "AuthToken")
//        print(name)
    }
    
//    func loadData() {
//        ActiveListings.
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""

        self.listing = listing!
//       collectionView.contentInsetAdjustmentBehavior = .never
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(handleNext))
        collectionView?.register(ListingSlides.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ListingInfoCell.self, forCellWithReuseIdentifier: titleId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.register(MapCell.self, forCellWithReuseIdentifier: mapId)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.backgroundColor = UIColor.white
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupNavBarButtons()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
        }
    }
//    fileprivate func setupNavigationButtons() {
////        navigationController?.navigationBar.tintColor = .black
////        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
//    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func setupNavBarButtons() {
            let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
            let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapSearchButton))
        let videoButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(handleVideo))
            navigationItem.rightBarButtonItems = [shareButton, videoButton]
          }
//    func setupNavBarButtons() {
//        let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
//
//        let videoButton = UIBarButtonItems([image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
//        navigationItem.rightBarButtonItem = videoButton],[image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
//        navigationItem.rightBarButtonItem = videoButton])
//        let videoButton = UIBarButtonItem(
//    }
    
    lazy var itemsToShare = listing?.StandardFields.UnparsedAddress
   @objc func didTapSearchButton() {
     let items = [itemsToShare]
     let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
     present(ac, animated: true)
        print("we search")
//        let docUrl = listing?.StandardFields.Documents?.first?.ResourceId
//        print(docUrl)
    }
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return (Any).self
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if activityType == .some(.postToFacebook) {
            return "Facebook"
        }
        if activityType == .some(.mail) {
            return "Send Us a Message"
        }
        if activityType == .some(.message) {
            return "send us a text"
        }
        return nil
    }
    @objc func handleVideo(url:NSURL) {
        guard let vidUrl = listing?.StandardFields.VirtualTours?.first?.Uri else { return }
            print(vidUrl)
        let url = URL(string:vidUrl)
        let player = AVPlayer(url: url!)

        let playerController = AVPlayerViewController()

        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
        
        

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         collectionView?.collectionViewLayout.invalidateLayout()
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if indexPath.item == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! TitleCell
//            cell.listing = listing
//            return cell
//        }
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! ListingInfoCell
            cell.listing = listing
            return cell
        }


        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
        if indexPath.item == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapId, for: indexPath) as! MapCell
            cell.mapView.mapType = .standard
//            cell.mapView.mapType = .satelliteFlyover

            cell.mapView.delegate = self
            if let lat = listing?.StandardFields.Latitude, let lng = listing?.StandardFields.Longitude {
                
                let location = CLLocationCoordinate2DMake(lat, lng)
                let coordinateRegion = MKCoordinateRegion.init(center: location, latitudinalMeters: 27500.0, longitudinalMeters: 27500.0)
                cell.mapView.setRegion(coordinateRegion, animated: true)
                
                let pin = MKPointAnnotation()
                
                
                pin.coordinate = location
                pin.title = listing?.StandardFields.UnparsedFirstLineAddress
                
                if let listPrice = listing?.StandardFields.ListPrice {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    
                    let subtitle = "$\(numberFormatter.string(from: NSNumber(value:(UInt64(listPrice) )))!)"
                    
                    pin.subtitle = subtitle
                }

                cell.mapView.addAnnotation(pin)

            }
            return cell            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListingSlides
        cell.listing = listing
        return cell
    }
   
 

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is ListingAnno else {
//          return nil
//        }
        guard !(annotation is MKUserLocation) else {
               return nil
           }

        let annotationIdentifier = "AnnotationIdentifier"

        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        annoView.pinTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
//        annoView.image = UIImage(named: "small-pin-map-7")

//        let swiftColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
////        annoView.centerOffset = CGPoint(x: 100, y: 400)
//        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
//        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
//        rightButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rightButton.setImage(UIImage(named: "small-pin-map-7"), for: UIControl.State())
        annoView.rightCalloutAccessoryView = rightButton
       
        
        //Add a LEFT IMAGE VIEW
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFill
        
        if let thumbnailImageUrl = listing?.StandardFields.Photos?[0].Uri640 {
            leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
        }
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        leftIconView.clipsToBounds = true
        annoView.leftCalloutAccessoryView = leftIconView
        

//        annoView.image = UIImage(named: "small-pin-map-7")
        
        return annoView
    }
    
    func goOutToGetMap() {
        
        
        let lat = listing?.StandardFields.Latitude
        let lng = listing?.StandardFields.Longitude
        let location = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        
        let item = MKMapItem(placemark: placemark)
        item.name = listing?.StandardFields.UnparsedFirstLineAddress
        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 1,
                                         MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
                                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
            self.goOutToGetMap()
        }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) { }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        alertController.addAction(cancelAction)
    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
        if let desc = listing?.StandardFields.PublicRemarks {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        }
        
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 80)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height)
        }
        if indexPath.item == 2 {
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        if indexPath.item == 3 {
            return CGSize(width: view.frame.width, height: 250)            
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
    
}

class AppDetailDescriptionCell: BaseCell {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    

    override func setupViews() {
        super.setupViews()
        addSubview(textView)
//        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: textView)
    }
}



class MapCell: BaseCell, MKMapViewDelegate  {
    
    var mapView = MKMapView()
    
    var listing: SoldListings? {
        willSet {
        }
    }
    
    override func setupViews() {
        
        addSubview(mapView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: mapView)
    }
}


