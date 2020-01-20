//
//  SoldLocationsCarousel.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools
import MapKit



class SoldLocationCell: LBTAListCell<MKMapItem> {
//   var listing:AllListings!
    var listing:MapOfSoldListings!
      
    var homeController:HomeViewController?
    override var item: MKMapItem! {
        didSet {
            label.text = item.name
//            priceLabel.text = homeController?.authToken.AuthToken
//            priceLabel.text =
            print(priceLabel)
        }
    }
    
    let label = UILabel(text: "This is a road", font: .boldSystemFont(ofSize: 16), numberOfLines: 2)
    let priceLabel = UILabel(text: "Address", font: .boldSystemFont(ofSize: 16))
    
    override func setupViews() {
        backgroundColor = .white
        
        setupShadow(opacity: 0.1, radius: 5, offset: .zero, color: .black)
        layer.cornerRadius = 5
        clipsToBounds = false
//        stack(label, priceLabel,UIView(), spacing: 10).withMargins(.allSides(8))
        hstack(stack(label, priceLabel, spacing: 12).withMargins(.allSides(16)),
        alignment: .center)
    }
}

class SoldLocationsCarouselController: LBTAListController<SoldLocationCell, MKMapItem> {
    
    weak var soldMapOfListingVC: MapOfSoldListings?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(self.items[indexPath.item].name)
        let annotations = soldMapOfListingVC?.mapView.annotations
        annotations?.forEach({ (annotation) in
            guard let customAnnotation = annotation as? MapOfSoldListings.CustomMapItemAnnotation else { return }
            if customAnnotation.mapItem?.name == self.items[indexPath.item].name {
                soldMapOfListingVC?.mapView.selectAnnotation(annotation, animated: true)
            }

        })
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
    }
  
}
extension SoldLocationsCarouselController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          .init(width: view.frame.width - 64, height: 100)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return .init(top: 0, left: 16, bottom: 0, right: 16)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 12
      }
}
