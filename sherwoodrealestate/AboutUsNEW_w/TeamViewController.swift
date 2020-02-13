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
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)

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
       setUpNavBar()
        

        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
    }
    func setUpNavBar() {
        
        let width = view.frame.width
        let titleView = UIView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
        
        titleView.hstack(logoImageView.withWidth(120))
        navigationItem.titleView = titleView
    }
    //1 Populate Cells with data
    //2 Extract this Function fetchDataSherwood() outside of this controller file
    

    var teamResults = [Result]()
    func fetchDataSherwood() {
        Service.shared.fetchSherwood { (results, error) in
            if let error = error {
                print("failed to fetch", error)
            }
            self.teamResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TeamCell
//        let teamSet = team?[indexPath.item]
//        cell.titleLabel = [indexPath.item]
//        cell.teamSet = team?[indexPath.item]
        
       
        // MARK:
       // without DID SET
       
       // let teamResult = teamResults[indexPath.item]

       // cell.bodyLabel.text = teamResult.Representative
       // cell.titleLabel.text = teamResult.JobTitle
       // cell.jobTitleRemarks.text = teamResult.PublicRemarks
       // cell.imageView.sd_setImage(with: URL(string: teamResult.imageUrl))

        cell.setTeam = teamResults[indexPath.item]
        
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamResults.count
    }
    
}


class TeamCell: UICollectionViewCell {
//    let nameLabel = UILabel(text: "set3", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let titleLabel = UILabel(text: "33", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let repNameLabel = UILabel(text: "alex", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let jobTitleRemarks = UILabel(text: "alex", font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()

    var setTeam: Result? {
        didSet {
            guard let setTeam = setTeam else { return }
            
            repNameLabel.text = setTeam.Representative
            titleLabel.text = setTeam.JobTitle
            jobTitleRemarks.text = setTeam.PublicRemarks
            imageView.sd_setImage(with: URL(string: setTeam.imageUrl))
            
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
        stack(imageView, repNameLabel,titleLabel,jobTitleRemarks,separatorView.withHeight(24),UIView(), spacing: 4, alignment: .center, distribution: .equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
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
        return CGSize(width: view.frame.width, height: 550)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



