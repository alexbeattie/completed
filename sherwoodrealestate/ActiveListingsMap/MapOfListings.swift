//
//  MapOfListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/3/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import LBTATools
import SDWebImage

class MapOfListings: UIViewController {
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
    var homeController:HomeViewController?


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.fetchListings()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
     
        checkLocationAuthorization()
        self.view = mapView
        mapView.delegate = self
       
        mapView.showsUserLocation = false
        
        setupRegionForMap()
        self.fetchListings()
        setUpCarouselLocation()
        locationsController.mapOfListingVC = self
        
    }
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 34.144404, longitude: -118.872124)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    let locationsController = LocationsCarouselController(scrollDirection: .horizontal)

    func setUpCarouselLocation() {
//        let locationView = UIView(backgroundColor: .red)
        let locationView = locationsController.view!
        
        view.addSubview(locationView)
        locationView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 150))
    }
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
      }
    }
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        mapView.showsUserLocation = true
       case .denied: // Show alert telling users how to turn on permissions
       break
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
      case .restricted: // Show an alert letting them know what’s up
       break
      case .authorizedAlways:
       break
      @unknown default: break
        
        }
    }
    
    let ldvc = ListingDetailController()
    
   

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annoview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//
////                annoview.pinTintColor = MKPinAnnotationView.purplePinColor()
//
//
////                let leftIconView = UIImageView()
////                leftIconView.contentMode = .scaleAspectFill
////
//////                let thumbnailImageUrl = ldvc?.listing?.StandardFields.Photos[0].Uri800
//////                print(thumbnailImageUrl)
////
////        if let thumbnailImageUrl = ldvc?.listing?.StandardFields.Photos?[0].Uri800 {
////                    leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
////                    print(thumbnailImageUrl)
////                }
//////
////                let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
////                leftIconView.bounds = newBounds
////                annoview.leftCalloutAccessoryView = leftIconView
//
//
////            }
////            let leftIconView = CustomImageView()
////            leftIconView.contentMode = .scaleAspectFill
////
////            if let thumbnailImageUrl = ldvc?.listing?.StandardFields.Photos[0].Uri1600 {
////                leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
////                print(thumbnailImageUrl)
////            }
//
////            let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
////            leftIconView.bounds = newBounds
////            annoview.leftCalloutAccessoryView = leftIconView
////        let pinImage = UIImage(named: "apps")
////             annoview.image = pinImage
//
//            return annoview
//
////        return nil
//    }

//    var listing: ActiveListings.listingResults?
    var listing: ActiveListings.listingResults? {
        didSet {
            
            if listing?.StandardFields.Photos?[0].Uri640 != nil {
                return
            }

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

    class CustomListingAnno:MKPointAnnotation {
        var listingItem: ListingAnno?
        var imageUrl: UIImage?
    }
//    class CustomMapItemAnnotation: MKPointAnnotation {
//        var mapItem: MKMapItem?
//        var image:UIImageView?
////    }
//    class ImageAnnotationView: MKAnnotationView {
//        private var imageView: UIImageView!
//
//        override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//            self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            self.addSubview(self.imageView)
//
//            self.imageView.layer.cornerRadius = 5.0
//            self.imageView.layer.masksToBounds = true
//        }
//
//        override var image: UIImage? {
//            get {
//                return self.imageView.image
//            }
//
//            set {
//                self.imageView.image = newValue
//            }
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    }

    func fetchListings() {
//        var thePoint = MKPointAnnotation()

        ActiveListings.fetchListing { (listing) in
            self.locationsController.items.removeAll()

            for anno in listing.D.Results {
                
//                self.locationsController.items.removeAll()
                let title = anno.StandardFields.UnparsedFirstLineAddress
                let lat = anno.StandardFields.Latitude
                let lon = anno.StandardFields.Longitude
                let subTitle = anno.StandardFields.ListPrice
                let image = URL(string: anno.StandardFields.Photos?[0].Uri640 ?? "")
               // let img = anno.StandardFields.Photos.flatMap({$0})
                

                
                let coordinate = CLLocationCoordinate2DMake((lat ?? nil)!, (lon ?? nil)!)
                
//                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
//                mapItem.isCurrentLocation
                let listingItem = ListingAnno(title: title ?? "", coordinate: coordinate, subTitle: subTitle ?? 0, image: UIImage())
                DispatchQueue.main.async {

                let session = URLSession(configuration: .default)

                // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                let downloadPicTask = session.dataTask(with: image!) { (data, response, error) in
                    // The download has finished.
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        // No errors found.
                        // It would be weird if we didn't have a response, so check for that too.
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded cat picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                let image = UIImage(data: imageData)
                                // Do something with your image.
                                listingItem.image = image
//                                image.sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri640 ?? ""))
                                
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }

                downloadPicTask.resume()
                }
                
//                var thePoint = CustomMapItemAnnotation()
//                print(thePoint)
                let theCustom = CustomListingAnno()
                theCustom.listingItem = listingItem
//                listingItem.
//                sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri800 ?? ""))
//                let thePoint = CustomMapItemAnnotation()
                //thePoint.mapItem = mapItem
                
//                theCustom.listingItem = listingItem
                //thePoint.coordinate = mapItem.placemark.coordinate
//                let leftIconView = CustomImageView()
//                if let thumbnailImageUrl = image {
//                    leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
//                }
                theCustom.coordinate = listingItem.coordinate
                theCustom.title = listingItem.title
                theCustom.subtitle = listingItem.subtitle as? String
//                theCustom.image.sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri800 ?? ""))
            
                let imageUrlString = anno.StandardFields.Photos?[0].Uri800
//                let imageUrl = URL(string: imageUrlString ?? "")!
//                let imageData = try! Data(contentsOf: imageUrl)
//                theCustom.image = UIImage(data: imageData)
//                theCustom.image
//                let imageUrl = URL(string: imageUrlString)!

//                theCustom.image = try? UIImage(imageUrl)
//                theCustom.listingItem?.image? = URL(string: anno.StandardFields.Photos?[0].Uri800 ?? "")
//                https://cdn.resize.sparkplatform.com/vc/800x600/true/20191218033547809935000000-o.jpg
//                sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri800 ?? ""))
                
//                let leftIconView = UIImageView()
//                leftIconView.contentMode = .scaleAspectFit
//
//                leftIconView.sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri640 ?? ""))
//                let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
//                leftIconView.bounds = newBounds
                
//                annoView.leftCalloutAccessoryView = leftIconView

//                theCustom.listingItem?.sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri640 ?? ""))
                
               
                //mapItem.name = title
                //thePoint.title = title
                //thePoint.subtitle = subTitle
               
                
//                let leftIconView = UIImageView()
//                if let thumbnailImageUrl = img?[0].Uri640 {
//                    leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
//                }
//                //this works too idk
////                thePoint.image = leftIconView
//                leftIconView.sd_setImage(with: URL(string: img?[0].Uri640 ?? ""))
                self.mapView.addAnnotation(theCustom)
                self.locationsController.items.append(listingItem)
            }
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
        self.locationsController.collectionView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        locationsController.items.removeAll()
           mapView.removeAnnotations(self.mapView.annotations)
       }
    }



extension MapOfListings: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            return nil  //Default is to let the system handle it.
        }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true

        let rightButton = UIButton(type: UIButton.ButtonType.infoDark)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        annotationView.rightCalloutAccessoryView = rightButton


//        let leftIconView = UIImageView()
//        leftIconView.contentMode = .scaleAspectFit
//        leftIconView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        DispatchQueue.main.async {
//            leftIconView.sd_setImage(with: URL(string: self.listing?.StandardFields.Photos?[0].Uri800 ?? ""))
//        }
//        annotationView.leftCalloutAccessoryView = leftIconView;

        
        return annotationView
//            return view
        
//        return nil
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let selectedAnnotation = view
//        print(selectedAnnotation)
        
//        guard let customAnnotation = view.annotation as? CustomMapItemAnnotation else { return }
//        guard let index = self.locationsController.items.firstIndex(where: {$0.name == customAnnotation.mapItem?.name}) else { return }
//        self.locationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)

        
        
        guard let customAnnotation = view.annotation as? CustomListingAnno else { return }
        guard let index = self.locationsController.items.firstIndex(where: {$0.title == customAnnotation.listingItem?.title}) else { return }
        self.locationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
            
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
          
            if let app = listing {
                //                didSelectHandler?(app)
//                print(app)
            }
//            print(MKAnnotationView.self)
            //            let placeName = capital.title
            //            let placeInfo = capital.info
            let layout = UICollectionViewFlowLayout()
            let activeListingDetailController = ListingDetailController(collectionViewLayout: layout)
            activeListingDetailController.listing = listing
            //            let myId = listing?.ResourceUri
            //            print("tapped")
            //             = listing?.ResourceUri
            let indexPath = activeListingDetailController.listing?.ResourceUri
//            print(indexPath)
            self.navigationController?.pushViewController(activeListingDetailController, animated: true)
            //
            //            let ac = UIAlertController(title: placeName, message: placeName, preferredStyle: .alert)
            //            ac.addAction(UIAlertAction(title: "Look more...", style: .default, handler: { [weak self] (alertAction) in
            //                self?.navigationController?.pushViewController(activeListingDetailController, animated: true)
            //                print(ac)
            //
            //            }))
            //            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            //            present(ListingDetailController, animated: true)//            let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
            //            let mapItem = MKMapItem(placemark: placemark)
            //            mapItem.name = view.annotation!.title!
            //            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            //
            //
            //            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
}
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
