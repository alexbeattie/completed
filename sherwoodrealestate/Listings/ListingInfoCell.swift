//
//  ListingInfoCell.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/12/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools
import SwiftUI

class ListingInfoCell: UICollectionViewCell {
    
    
    
    let listingAddressLabel = UILabel(text: "address", font:.boldSystemFont(ofSize: 16), textColor: .darkGray, textAlignment: .center)
    let listingCityLabel = UILabel(text: "city", font:.systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center )
    let listingStateLabel = UILabel(text: "state", font:.systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    let listingIdLabel = UILabel(text: "ListingId", font:.systemFont(ofSize: 12))
    let mlsStatusLabel = UILabel(text: "MLS Status", font:.systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    let coListAgentNameLabel = UILabel(text: "CoList", font:.systemFont(ofSize: 12))
    let listingAgentName = UILabel(text: "listingAgent", font:.systemFont(ofSize: 12))
    let openHousesLabelDate = UILabel(text: "openHouses", font:.systemFont(ofSize: 12))
    let openHousesLabelStart = UILabel(text: "openHouses", font:.systemFont(ofSize: 12))
    let openHousesLabelEnd = UILabel(text: "openHouses", font:.systemFont(ofSize: 12))
    let bedsTotalLabel = UILabel(text: "bedRooms", font:.systemFont(ofSize: 14),textColor: .darkGray, textAlignment: .center)
    
    let squareFootage = UILabel(text: " ", font:.systemFont(ofSize: 14),textColor: .darkGray, textAlignment: .center)

    let bathsLabel = UILabel(text: "Bathrooms:", font:.systemFont(ofSize: 14),textColor: .darkGray, textAlignment: .center)
    let costLabel = UILabel(text: "cost", font:.systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    let zipLabel = UILabel(text: "zip", font:.systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    var container = UIView(backgroundColor: .green)
//    var customFields: ActiveListings.customFields! {
//        didSet {
//            
//        }
//    }
    var listing: ActiveListings.listingResults! {
        didSet {
            
            
            
            
            listingCityLabel.adjustsFontForContentSizeCategory = true
            
            listingAddressLabel.text = listing?.StandardFields.UnparsedFirstLineAddress?.localizedCapitalized
            /*
            listingAddressLabel.layer.backgroundColor = UIColor.yellow.cgColor
            listingCityLabel.layer.backgroundColor = UIColor.red.cgColor
            listingStateLabel.layer.backgroundColor = UIColor.red.cgColor
            zipLabel.layer.backgroundColor = UIColor.red.cgColor
            */
//            listingCityLabel.text = listing?.StandardFields.City
//            listingStateLabel.text = String("\(listing?.StandardFields.StateOrProvince)")
            listingIdLabel.text = listing?.StandardFields.ListingId
            mlsStatusLabel.text = String("Status: \(listing?.StandardFields.MlsStatus)")
            coListAgentNameLabel.text = listing?.StandardFields.CoListAgentName
            listingAgentName.text = listing?.StandardFields.ListAgentName
            
            if let city = listing?.StandardFields.City {
                listingCityLabel.text = "\(city), "
            }
            if let state = listing?.StandardFields.StateOrProvince {
                listingStateLabel.text = state
            }
           
            if let zipcode = listing?.StandardFields.PostalCode {
                zipLabel.text = zipcode
            }
            //squareFootage.layer.backgroundColor = UIColor.green.cgColor
            if let squareFeet = listing?.StandardFields.BuildingAreaTotal {
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                let someDouble:Int = Int(squareFeet)
                let newTrick = "\(nf.string(from: NSNumber(value:(UInt64(someDouble))))!)"
                squareFootage.text = NSString(utf8String: "\(newTrick) SF") as String?
            }
           // bedsTotalLabel.layer.backgroundColor = UIColor.green.cgColor
            if let bathsTotal = listing?.StandardFields.BathsFull {
                bathsLabel.text = ("\(bathsTotal) BA")
            }
            //bedsTotalLabel.layer.backgroundColor = UIColor.green.cgColor
            if let bedsTotal  = listing?.StandardFields.BedsTotal {
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                if (listing?.StandardFields.BedsTotal) != nil {
                    bedsTotalLabel.text = String(describing: ("\(bedsTotal) BR"))
                }
            }
            
            if (listing?.StandardFields.MlsStatus) != nil {
                mlsStatusLabel.text = String(" ")
            }
            if let listingId = listing?.StandardFields.ListingId {
                listingIdLabel.text = String("Listing ID: \(listingId)")
            }
            
            if let colistingAgent = listing?.StandardFields.CoListAgentName {
                coListAgentNameLabel.text = String("Co Listed: \(colistingAgent)")
            }
            
            if let listPrice = listing?.StandardFields.ListPrice {
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                let subTitleCost = "$\(nf.string(from: NSNumber(value:(UInt64(listPrice))))!)"
                costLabel.text = NSString(utf8String: "\(subTitleCost)") as String?
                print(subTitleCost)
            }
            
            //            if let openHousesLabelStart = listing?.StandardFields.OpenHouses[0].StartTime {
            //                print(openHousesLabelStart)
            //            }
            //            if let openHousesLabelEnd = listing?.StandardFields.OpenHouses[0].EndTime {
            //               print(openHousesLabelEnd)
            //            }
            //            if let openHousesLabelDate = listing?.StandardFields.OpenHouses[0].Date {
            //               print(openHousesLabelDate)
            //           }
            
        }
    }
//    var customInfo: Main? {
//        didSet {
//            GeneralPropertyInformation.init(constructionStatus: "", commonWalls: "")
//            
//        }
//    }
    
 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        var container: UIView = {
//             let view = UIView()
//             view.backgroundColor = UIColor.gray
//             view.layer.shadowColor = UIColor.black.cgColor
//             view.layer.cornerRadius = 4
//             view.layer.shadowOpacity = 0.5
//             view.layer.shadowRadius = 4
//             view.layer.shadowOffset = CGSize(width: 0, height: 1)
//             view.translatesAutoresizingMaskIntoConstraints = false
//             return view
//         }()
        
//        stack(container)
//        container.fillSuperview()
//        container.anchor(top: costLabel.centerYAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 80, bottom: 20, right: 80))
//        contentView.addSubview(container)
//        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        container.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        container.trailingAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
       
        // MARK: Stacks
                       /* costLabel
         listingAddressLabel, listingCityLabel, zipLabel
         bedsTotalLabel, bathsLabel, squareFootage
                        mlsStatusLabel
                        */
        
        // container view
        
//        let infoCellContainerView = UIView(backgroundColor: .lightGray)
        
        
        // labels to be in view
        let infoCellStack = UIStackView(arrangedSubviews: [costLabel, listingAddressLabel, listingCityLabel, zipLabel, bedsTotalLabel, bathsLabel, squareFootage, mlsStatusLabel])
        
//        let infoCellContainerStack = UIStackView(arrangedSubviews:[infoCellContainerView])
//        infoCellContainerStack.addArrangedSubview(infoCellContainerView)
        
//        print("There are \(infoCellStack.arrangedSubviews.count) StackViews in the infoCell Stack")
//        print("There are \(infoCellContainerStack.arrangedSubviews.count) cells in the ContainerStack")
//
//        infoCellStack.axis = .vertical
//        infoCellContainerStack.axis = .vertical
//
////        stack(listingAddressLabel)
//        hstack(infoCellContainerView)
//        let constraint = listingAddressLabel.widthAnchor.constraint(equalToConstant: 200)
//        constraint.priority = .init(999)
//        constraint.isActive = true
        stack(
        hstack(listingAddressLabel, spacing: 0, alignment: .bottom, distribution:.fill),
        hstack(listingCityLabel,listingStateLabel, zipLabel,UIView(), spacing: 2, alignment: .center, distribution:.equalSpacing),
        hstack(bedsTotalLabel,bathsLabel, squareFootage, spacing: 2, alignment: .top, distribution:.equalSpacing),
        hstack(costLabel, spacing: 2, alignment: .top, distribution:.fillEqually), spacing: 2, alignment: .center, distribution: .fillEqually).withMargins(.init(top: 4, left: 0, bottom: 4, right: 0))
        /*
        stack(listingAddressLabel,
            stack(hstack(listingCityLabel, listingStateLabel, zipLabel, UIView(),
                           spacing: 2, alignment: .top, distribution: .equalSpacing), alignment: .center, distribution: .equalSpacing),
            stack(hstack(bedsTotalLabel, bathsLabel,squareFootage,UIView(), spacing: 4, alignment: .top), alignment: .center, distribution: .equalSpacing),stack(hstack(costLabel)),
            stack(mlsStatusLabel, alignment: .top, distribution: .equalSpacing))
        */
       
        
        
        
        
        
        
        
        //self.contentView.addSubview(container)

        
        let gradientLayer = CAGradientLayer()
        
        func setupGradientLayer() {
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            layer.cornerRadius = 20
            layer.masksToBounds = true
            layer.addSublayer(gradientLayer)
        }
        func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
