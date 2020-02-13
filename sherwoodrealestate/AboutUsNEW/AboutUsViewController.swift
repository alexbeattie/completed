//
//  SoldViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/11/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
//    let cellId = "cellId"
//    var newList:Listing!
    
//    var listings: [Listing.listingResults]?
//
//    var photos : [Listing.standardFields.PhotoDictionary]?
//    let app: AppDelegate!
    var picture = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//            if var token = defaults.value(forKey: "Token") as? String {
//                print("defaults Token: \(token)")
//            }

        collectionView?.backgroundColor = .orange
        collectionView?.register(AboutUsCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = listings?.count {
//            return count
//        }
//        return 0
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AboutUsCell
        
//        let appGroup = listings?[indexPath.item]
        
//        cell.titleLabel.text = appGroup?.StandardFields.UnparsedAddress
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }

}
