//
//  SoldListingDetailController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/8/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

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
import MessageUI

class SoldListingDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate {
    let cellId = "cellId"
    let footerId = "footerId"
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
    var authToken:[SoldListings.resultsArr]?
    var expires:[SoldListings.resultsArr]?

    

    
    var listing: SoldListings.listingResults? {
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
        
        }
    }
    var theToken: SoldListings.resultsArr?
//        didSet {
//
//            if theToken?.AuthToken != nil {
//                return
//            }
//            print(theToken)
//        }

    @objc func handleNext() {

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.register(SoldListingSlides.self, forCellWithReuseIdentifier: cellId)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Previously Sold"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(handleNext))

//        collectionView.contentInsetAdjustmentBehavior = .never
//        let videoButton = UIBarButtonItem(image: .strokedCheckmark, style: .plain, target: self, action: #selector(sendMail))
        //        navigationItem.rightBarButtonItem = videoButton
//        self.navigationItem.rightBarButtonItem = videoButton
        
//        collectionView?.register(SoldListingSlides.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(SoldListingInfoCell.self, forCellWithReuseIdentifier: titleId)
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
    func setupNavBarButtons() {
            let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
            let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapSearchButton))
            let videoButton = UIBarButtonItem(image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
            navigationItem.rightBarButtonItems = [shareButton, videoButton]
          }
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
//    func setupNavBarButtons() {
//        let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
//        let videoButton = UIBarButtonItem(image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
//        navigationItem.rightBarButtonItem = videoButton
//    }
    
//        print(123)

//        guard let vidUrl = listing?.StandardFields.Videos[0].ObjectHtml else { return }
//        guard let vidUrl =
//    
//        guard let vidUrl = listing?.standardFields.VirtualTours.first.Uri else { return }
//                  print(vidUrl)
//              let url = URL(string:vidUrl)
//              let player = AVPlayer(url: url!)
//
//              let playerController = AVPlayerViewController()
//
//              playerController.player = player
//              present(playerController, animated: true) {
//                  player.play()
//              }

       
//    }
    var toolbar:UIToolbar!
      @objc func addMe(sender: UIBarButtonItem) {
            let textToShare = (listing?.StandardFields.UnparsedFirstLineAddress)
        guard let site = NSURL(string: (listing?.StandardFields.Photos?[0].Uri800)!) else { return }
        let objectsToShare = [textToShare ?? "", site] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView
            activityVC.popoverPresentationController?.barButtonItem = sender
            self.present(activityVC, animated: true, completion: nil)
        }

    @objc func sendMail(sender: UIBarButtonItem) {
            print("nothing")
              if MFMailComposeViewController.canSendMail() {
                var newMessage = ""
                if let msg = listing?.StandardFields.UnparsedAddress {
                    newMessage = msg
                }
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["you@yoursite.com"])
                mail.setMessageBody("<p>Can you send me information about \(newMessage)</p>" , isHTML: true)

                present(mail, animated: true)
            } else {
                // show failure alert
            }

        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
//    func setUpToolBarButtons() {
//    //        barBtn.tintColor = UIColor.black
//
//            UIBarButtonItem.appearance().tintColor = UIColor.black
//            toolbar = UIToolbar(frame: CGRect(x:0, y:self.view.bounds.size.height - 64, width: self.view.bounds.size.width, height: 70.0))
//            toolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-40.0)
//
//        _ = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(sendMail(sender:)))
//        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addMe(sender:)))
//        let search = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: nil)
////        let organize = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: nil)
////        let camera = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: nil)
//
//        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//
//            toolbar.items = [add, flexible, flexible, search]
//    //        self.toolbar.items. = UITabBarItemPositioning.automatic
//            self.view.addSubview(toolbar)
//
//    //        camera.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -26, right: 0)
//    //        add.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -26, right: 0)
//    //        search.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -26, right: 0)
//    //        organize.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -26, right: 0)
//    //        compose.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -26, right: 0)
//
//            guard let items = toolbar.items else { return }
//            for item in items {
//                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
//
//            }
//        }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! TitleCell
//            cell.listing = listing
//            return cell
//        }
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! SoldListingInfoCell
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoldListingSlides
//        activityIndicatorBegin()

        cell.listing = listing
        return cell
    }
   
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        let swiftColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        annoView.centerOffset = CGPoint(x: 100, y: 400)
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        annoView.rightCalloutAccessoryView = rightButton
        
        //Add a LEFT IMAGE VIEW
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFill
        
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
        item.name = listing?.StandardFields.UnparsedAddress
        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
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
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
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
        return CGSize(width: view.frame.width, height: 250)
    }
    
    
    
}


class SoldTitleCell: BaseCell {
    var listing: SoldListings.listingResults? {
        didSet {
            
        
            if let theAddress = listing?.StandardFields.UnparsedAddress {
                
                nameLabel.text = theAddress
            }
            
            if let listPrice = listing?.StandardFields.ListPrice{
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                let subTitleCost = "$\(nf.string(from: NSNumber(value:(UInt64(listPrice) )))!)"
                costLabel.text = subTitleCost
            }
            if let lid = listing?.StandardFields.ListingId {
                listingIdLabel.text = lid
            }
            
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "400"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    let listingIdLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    

    override func setupViews() {
        
        addSubview(viewContainer)
        addSubview(nameLabel)
        addSubview(costLabel)
        addSubview(listingIdLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: viewContainer)
        addConstraintsWithFormat(format: "V:|[v0(80)]|", views: viewContainer)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]-8-|", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: costLabel)
        addConstraintsWithFormat(format: "V:|-22-[v0]", views: costLabel)

        addConstraintsWithFormat(format: "H:|[v0]|", views: listingIdLabel)
        addConstraintsWithFormat(format: "V:|-22-[v0]", views: listingIdLabel)

//        listingIdLabel.anchor(top: costLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 2, bottom: 0, right: 2))
        
    }
}
class SoldAppDetailDescriptionCell: BaseCell {
    
    
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



class SoldMapCell: BaseCell, MKMapViewDelegate  {
    
    var mapView = MKMapView()
    
    var listing: SoldListings? {
        willSet {
            //            if let lat = listing?.geo?.lat, let lng = listing?.geo?.lng {
            //
//            let detailLabel = UILabel()
//            detailLabel.numberOfLines = 0
//            detailLabel.font = detailLabel.font.withSize(12)
//            detailLabel.text = pin.subtitle
//            detailCalloutAccessoryView = detailLabel            //                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, 27500.0, 27500.0)
            //                mapView.setRegion(coordinateRegion, animated: false)
            //
            //                let pin = MKPointAnnotation()
            //
            //                pin.coordinate = location
            //                mapView.addAnnotation(pin)
            //
            //            }
        }
    }
    
    override func setupViews() {
        
        addSubview(mapView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: mapView)
    }
}













//extension UIView {
//
//    func addConstraintsWithFormat(_ format: String, views: UIView...) {
//        var viewsDictionary = [String: UIView]()
//        for (index, view) in views.enumerated() {
//            let key = "v\(index)"
//            viewsDictionary[key] = view
//            view.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
//    }
//
//}

//class BaseCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews() {
//
//    }
//}
//
