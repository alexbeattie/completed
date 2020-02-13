//
//  TeamViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/12/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
import LBTATools


    
class TeamViewController: UICollectionViewController {
    
//    var teams = [TeamModel]()
    let cellId = "cellId"
//    var team : [TeamModel.standardFields]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Post.getData { (post) in
//            self.post = post
//            self.collectionView.reloadData()
//
//        }
//        TeamModel.getData { (_) in
//
//            _ = self.team
//            self.collectionView.reloadData()
//
//        }
       fetchDataSherwood()
        
        

        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
        
    }
    //1 Populate Cells with data
    //2 Extract this Function fetchDataSherwood() outside of this controller file
    

    var teamResults = [Result]()
    func fetchDataSherwood() {
        Service.shared.fetchSherwood()
    }
//    fileprivate func fetchDataSherwood() {
//        let urlString = "https://sherwoodrealestate.s3.amazonaws.com/about-sherwood.json"
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            if let err = err {
//                print("Failed to fetch apps", err)
//                return
//            }
//            //success
//                //print(data)
//            guard let data = data else { return }
//            //print(String(data: data, encoding: .utf8))
//            do {
//                let teamResult = try JSONDecoder().decode(TeamResult.self, from: data)
//               // print(teamResult)
//               // teamResult.Results.forEach({print($0.Representative, $0.JobTitle, $0.PublicRemarks, $0.imageUrl)})
//                self.teamResults = teamResult.Results
//                DispatchQueue.main.async() {
//                    self.collectionView.reloadData()
//                }
//
//            } catch let jsonErr {
//                print("Failed to decode JSON", jsonErr)
//            }
//
//
//        }.resume()
//
//    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TeamCell
//        let teamSet = team?[indexPath.item]
//        cell.titleLabel = [indexPath.item]
//        cell.teamSet = team?[indexPath.item]
        
        let teamResult = teamResults[indexPath.item]
        cell.bodyLabel.text = teamResult.Representative
        cell.titleLabel.text = teamResult.JobTitle
        cell.jobText.text = teamResult.PublicRemarks
        cell.imageView.sd_setImage(with: URL(string: teamResult.imageUrl))

        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = team?.count
//        {
        return teamResults.count
//        }
//        return 0
    }
    
}


class TeamCell: UICollectionViewCell {
//    let nameLabel = UILabel(text: "set3", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let titleLabel = UILabel(text: "33", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let bodyLabel = UILabel(text: "alex", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let jobText = UILabel(text: "alex", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)

    
    
//    var teamSet: TeamResult? {
//        didSet {
//            guard let teamSet = teamSet else { return }
//            print("Called after setting new value\n")
//            titleLabel.text = teamSet.representative
//            bodyLabel.text = teamSet.jobTitle
//
////            if let repName =  teamSet?.representative {
////                titleLabel.text = repName
////            }
////            if let jobTitle = teamSet?.jobTitle {
////                bodyLabel.text = jobTitle
////            }
////            if let jobText = teamSet?.publicRemarks {
////                           bodyLabel.text = jobText
////            }
//        }
//    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
      
        stack(imageView,bodyLabel,titleLabel,jobText,UIView(), spacing: 4, alignment: .leading, distribution: .equalSpacing).withMargins(.init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
}
//extension UILabel {
//
//    static func createCustomLabel() -> UILabel {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        return label
//    }
//}
extension TeamViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



