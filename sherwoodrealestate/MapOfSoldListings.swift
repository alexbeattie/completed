//
//  MapOfSoldListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/3/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import LBTATools
class MapOfSoldListings: UIViewController {
    
    var anno:ActiveListings.standardFields!
    var locationManager = CLLocationManager()
//    var listingAnnos:[ListingAnno] = [ListingAnno]()
    
    var mapView = MKMapView()
    var listing:SoldListings!
    
    var homeController:HomeViewController?
//    let distance: CLLocationDistance = 800
//    let pitch: CGFloat = 30
//    let heading = 45.0
//    var camera: MKMapCamera?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.fetchListings()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
//        UINavigationBar.appearance().tintColor = UIColor(red: 66, green: 66, blue: 66, alpha: 1)
     
        checkLocationAuthorization()
//        setUpCarouselLocation()
        self.view = mapView
        mapView.delegate = self
       
//        let location = CLLocationCoordinate2D(latitude:34.144404 , longitude:-118.872124 )
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)

        mapView.showsUserLocation = false
        
        setupRegionForMap()
//        setUpCarouselLocation()
         self.fetchListings()
        setUpCarouselLocation()
        locationsController.soldMapOfListingVC = self
        
    }
    let locationsController = SoldLocationsCarouselController(scrollDirection: .horizontal)

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

    
    
    
    
    
    let ldvc:ListingDetailController? = nil
    
   

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

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            
            let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = view.annotation!.title!
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            
            
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 34.144404, longitude: -118.872124)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    var thePoint = MKPointAnnotation()
//    class CustomMapItemAnnotation: MKPointAnnotation {
//        var mapItem: MKMapItem?
//    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        guard let customAnnotation = view.annotation as? CustomMapItemAnnotation else { return }
        guard let index = self.locationsController.items.firstIndex(where: {$0.name == customAnnotation.mapItem?.name}) else { return }
        self.locationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
            
    }
    class CustomMapItemAnnotation: MKPointAnnotation {
        var mapItem: MKMapItem?
//        var anno:Listing.standardFields!
    }
    func fetchListings() {
//        var thePoint = MKPointAnnotation()

        SoldListings.fetchListing { (listing) in
            self.locationsController.items.removeAll()

            for anno in listing.D.Results {
                
//                self.locationsController.items.removeAll()
                let title = anno.StandardFields.UnparsedAddress
                let lat = anno.StandardFields.Latitude
                let lon = anno.StandardFields.Longitude
                let subTitle = anno.StandardFields.ListOfficeName
                let coordinate = CLLocationCoordinate2DMake((lat ?? nil)!, (lon ?? nil)!)
                
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
                
               
                
//                var thePoint = CustomMapItemAnnotation()
//                print(thePoint)
                let thePoint = CustomMapItemAnnotation()
                thePoint.mapItem = mapItem
                thePoint.coordinate = mapItem.placemark.coordinate
                mapItem.name = title
                thePoint.title = title
                thePoint.subtitle = subTitle
//                destinationItem.phoneNumber = subTitle
//                annotation.title = "Location: " + (mapItem.name ?? "")
                
//                thePoint = MKPointAnnotation() as! MapOfListings.CustomMapItemAnnotation
                
//                thePoint.coordinate = coordinate
//                thePoint.subtitle = subTitle
//                print(destinationItem)
                self.mapView.addAnnotation(thePoint)
//                self.mapView.showAnnotations([thePoint], animated: true)
//                tell locationCarousel all of the items
                
//                print(thePoint)
                self.locationsController.items.append(mapItem)
//                self.locationsController.items.append(annotations)
            }
//            self.locationsController.items.append(thePoint/)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        }
        self.locationsController.collectionView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationsController.items.removeAll()

           mapView.removeAnnotations(self.mapView.annotations)
       }
    
   
}



extension MapOfSoldListings: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKPointAnnotation) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
            annotationView.canShowCallout = true
                            annotationView.animatesDrop = true

            let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
            rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
            rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
            rightButton.clipsToBounds = true
            annotationView.rightCalloutAccessoryView = rightButton
            return annotationView
        }
        return nil
    }
    
}
