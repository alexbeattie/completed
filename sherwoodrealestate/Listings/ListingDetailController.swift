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

class ListingDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate {
    let cellId = "cellId"
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    let mapId = "mapId"
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    var mapView:MKMapView!
    let pin = MKPointAnnotation()
    var region: MKCoordinateRegion!
    let locationManager = CLLocationManager()
    var authToken:[ActiveListings.resultsArr]?
    var expires:[ActiveListings.resultsArr]?
    var resourceId:[ActiveListings.resultsArr]?
    let brs:[ActiveListings.resultsArr]? = nil
    //let logoImageView = UIImageView(image: UIImage(named: "jordancohen"), contentMode: .scaleAspectFit)
//    let searchButton = UIButton(title: "Search", titleColor: .black)
//
    
    var listing: ActiveListings.listingResults? {
        didSet {
            
            if listing?.StandardFields.Photos != nil {
                return
            }
            if listing?.StandardFields.VirtualTours != nil {
                return
            }
            if listing?.StandardFields.Videos != nil {
                return
            }
            if listing?.StandardFields.Documents != nil {
               return
            }
//            if let listPrice = listing?.StandardFields.ListPrice {
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//
//                let subtitle = "$\(numberFormatter.string(from: NSNumber(value:(UInt64(listPrice) )))!)"
//                pin.subtitle = subtitle
//            }
        }
    }

       
    var theToken: ActiveListings.resultsArr?
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

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       collectionView.contentInsetAdjustmentBehavior = .never
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(handleNext))
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
//        setupNavigationButtons()
//        sendEmail()
    }
    
    
    @objc func handleNext() {

        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
            let videoButton = UIBarButtonItem(image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
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
    
   @objc func didTapSearchButton() {
        print("we search")
        let docUrl = listing?.StandardFields.Documents?.first?.ResourceId
//        print(docUrl)
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

//        let newVidUrl = URL(string: vidUrl)
//            print(newVidUrl)
        
//        let tourURL = URL(string: listing?.StandardFields.Tours?.first?.Uri ?? "")
//        print(tourURL)

//
//        print(listing?.StandardFields.VideoObjs?.first)
//
//        guard let vidUrl = listing?.StandardFields.Videos?[0].ObjectHtml else { return }
//        guard let vidUrl =
////        print(vidUrl)
//        if let firstVid = listing?.StandardFields.VideoObjs?.first {
//            print(firstVid)
//        }
//
//        if let secondVid = listing?.StandardFields.Tours?.first {
//            print(secondVid)
//        }
            
            
        
        
//            let vidUrl = firstVid
//            print(firstVid)
//            let url = URL(string:firstVid)
//            let player = AVPlayer(url: url!)
//            print(url)
//            let playerController = AVPlayerViewController()
////            }
//            playerController.player = player
//            present(playerController, animated: true) {
//                player.play()
//            }

//        }
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
             
//                let distance: CLLocationDistance = 800
//                let pitch: CGFloat = 30
//                let heading = 90.0
//                var camera: MKMapCamera?
//                camera = MKMapCamera(lookingAtCenter: location, fromDistance: distance, pitch: pitch, heading: heading)
//                cell.mapView.camera = camera!

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
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        let swiftColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
//        annoView.centerOffset = CGPoint(x: 100, y: 400)
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        
        annoView.rightCalloutAccessoryView = rightButton
        
        //Add a LEFT IMAGE VIEW
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFit
        
        if let thumbnailImageUrl = listing?.StandardFields.Photos?[0].Uri800 {
            leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
        }
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        annoView.leftCalloutAccessoryView = leftIconView
        
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
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 100)
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
            
            
            return CGSize(width: view.frame.width, height: 200)
            
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
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
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


