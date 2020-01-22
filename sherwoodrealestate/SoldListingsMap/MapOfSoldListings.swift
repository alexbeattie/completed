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
import SDWebImage

class MapOfSoldListings: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
          let greyView = UIView()

          public func activityIndicatorBegin() {
              activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
//                activityIndicator.center = self.center
                activityIndicator.hidesWhenStopped = true
              activityIndicator.style = UIActivityIndicatorView.Style.medium
//                addSubview(activityIndicator)
                activityIndicator.startAnimating()
            }

            public func activityIndicatorEnd() {
                self.activityIndicator.stopAnimating()
              self.activityIndicator.hidesWhenStopped = true
      //          enableUserInteraction()
      //          self.removeFromSuperview()
            }
//    var anno:ActiveListings.standardFields!
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
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
            }
        }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.fetchListings()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
//        UINavigationBar.appearance().tintColor = UIColor(red: 66, green: 66, blue: 66, alpha: 1)
//        self.title = "Map of Sold"
        navigationItem.title = "Map of Previously Sold"
        checkLocationAuthorization()
        self.view = mapView
        mapView.delegate = self
       
        mapView.showsUserLocation = false
        
        setupRegionForMap()
        self.fetchListings()
        setUpCarouselLocation()
        soldLocationsController.soldMapOfListingVC = self
        
        
    }
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 34.144404, longitude: -118.872124)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    let soldLocationsController = SoldLocationsCarouselController(scrollDirection: .horizontal)
    let homeController = HomeViewController()
    let ldvc = ListingDetailController()


    func setUpCarouselLocation() {
        let locationView = soldLocationsController.view!
        
        view.addSubview(locationView)
        soldLocationsController.collectionView.reloadData()
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
   
    
    class SoldCustomListingAnno:MKPointAnnotation {
          var listingItem: SoldListingsAnno?
          var imageUrl: UIImage?
      }

//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        guard let customAnnotation = view.annotation as? SoldCustomListingAnno else { return }
//        guard let index = self.soldLocationsController.items.firstIndex(where: {$0.name == customAnnotation.mapItem?.name}) else { return }
//        self.soldLocationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
//            
//    }
//    class CustomMapItemAnnotation: MKPointAnnotation {
//        var mapItem: MKMapItem?
////        var anno:Listing.standardFields!
//    }
        func fetchListings() {
            SoldListings.fetchListing { (listing) in
                //self.soldLocationsController.items.removeAll()

                for anno in listing.D.Results {
                    
    //                self.locationsController.items.removeAll()
                    let title = anno.StandardFields.UnparsedFirstLineAddress
                    let lat = anno.StandardFields.Latitude
                    let lon = anno.StandardFields.Longitude
                    let subTitle = anno.StandardFields.ListPrice
                    let image = URL(string: anno.StandardFields.Photos?[0].Uri640 ?? "")
                    
                    // let img = anno.StandardFields.Photos.flatMap({$0})
                                    
                    let coordinate = CLLocationCoordinate2DMake((lat ?? nil)!, (lon ?? nil)!)
                    
                    let listingItem = SoldListingsAnno(title: title ?? "", coordinate: coordinate, subTitle: subTitle ?? 0, image: UIImage())
//                    DispatchQueue.main.async {

                    let session = URLSession(configuration: .default)

                    // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                    let downloadPicTask = session.dataTask(with: image!) { (data, response, error) in
                        // The download has finished.
                        if let e = error {
                            print("Error downloading cat picture: \(e)")
                        } else {
                            // No errors found.
                            // It would be weird if we didn't have a response, so check for that too.
                            if let _ = response as? HTTPURLResponse {
    //                            print("Downloaded cat picture with response code \(res.statusCode)")
                                if let imageData = data {
                                    // Finally convert that Data into an image and do what you wish with it.
                                    DispatchQueue.main.async {

                                    let image = UIImage(data: imageData)
                                    // Do something with your image.
                                    listingItem.image = image
                                    }
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
                    
                    

                   let soldCustom = SoldCustomListingAnno()
                   soldCustom.listingItem = listingItem
                       //
                   soldCustom.coordinate = listingItem.coordinate
                   soldCustom.title = listingItem.title
                   soldCustom.subtitle = listingItem.subtitle as? String
               
                   self.mapView.addAnnotation(soldCustom)
                   self.soldLocationsController.items.append(listingItem)
                }
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
            
            self.soldLocationsController.collectionView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true)
            
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        soldLocationsController.items.removeAll()

           mapView.removeAnnotations(self.mapView.annotations)
       }
    
   
}



extension MapOfSoldListings: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            return nil  //Default is to let the system handle it.
        }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true
        annotationView.pinTintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)

        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        annotationView.rightCalloutAccessoryView = rightButton


        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let selectedAnnotation = view
//        print(selectedAnnotation)
                
        guard let customAnnotation = view.annotation as? SoldCustomListingAnno else { return }
        guard let index = self.soldLocationsController.items.firstIndex(where: {$0.title == customAnnotation.listingItem?.title}) else { return }
        self.soldLocationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
        
        
//        let layout = UICollectionViewFlowLayout()
//        let listingDetailController = ListingDetailController(collectionViewLayout: layout)
//        listingDetailController.listing = listing
        
        

//        let indexPath = soldLocationsController.items.count
//        let calloutView = indexPath
//        print(calloutView)

        
    }
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
//        if control == view.leftCalloutAccessoryView {
          
            
            
//            let layout = UICollectionViewFlowLayout()
//            let activeListingDetailController = ListingDetailController(collectionViewLayout: layout)
//            self.navigationController?.pushViewController(activeListingDetailController, animated: true)

//        }
        
//        else if control == view.rightCalloutAccessoryView {
            
            let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = view.annotation!.title!
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
//        }
    }
}
