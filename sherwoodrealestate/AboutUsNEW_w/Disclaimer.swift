//
//  Disclaimer.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//


import UIKit
import Foundation
import LBTATools


    
class DisclaimerViewController: UICollectionViewController {
    let cellId = "cellId"
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
//    lazy var settingsLauncher: SettingsLauncher = {
//        let launcher = SettingsLauncher()
//        launcher.homeController = self
//        return launcher
//    }()
//    @objc func handleMore() {
//           settingsLauncher.showSettings()
//       }
//    func setupNavBarButtons() {
//        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon-2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
//        navigationItem.rightBarButtonItem?.tintColor = .black
//
//
//           navigationItem.rightBarButtonItem = moreButton
//        navigationItem.rightBarButtonItem?.tintColor = .black
//       }
//    func showControllerForSetting(setting: Setting) {
//        let dummySettingsViewController = UIViewController()
//        dummySettingsViewController.view.backgroundColor = UIColor.white
//        dummySettingsViewController.navigationItem.title = setting.name.rawValue
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController?.pushViewController(dummySettingsViewController, animated: true)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
       setUpNavBar()
//        setupNavBarButtons()
//        self.disclaimers = Disclaimer
        
        fetchDataSherwood()
        collectionView.register(DisclaimerCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.reloadData()
        
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
    
    var disclaimers = [Disclaimer]()
    func fetchDataSherwood() {
        TosService.shared.fetchDisclaimer { (disclaimerResults, error) in
            if let error = error {
                print("failed to fetch", error)
            }
            self.disclaimers = disclaimerResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DisclaimerCell
//        let teamSet = team?[indexPath.item]
//        cell.titleLabel = [indexPath.item]
//        cell.teamSet = team?[indexPath.item]
//        cell.dis = disclaimers[indexPath.item]
        cell.dis = disclaimers[indexPath.item]
       
        // MARK:
       // without DID SET
       
       // let teamResult = teamResults[indexPath.item]

       // cell.bodyLabel.text = teamResult.Representative
       // cell.titleLabel.text = teamResult.JobTitle
       // cell.jobTitleRemarks.text = teamResult.PublicRemarks
       // cell.imageView.sd_setImage(with: URL(string: teamResult.imageUrl))

//        cell.dis = disclaimers[indexPath.item]
        
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disclaimers.count
    }
    
}


class DisclaimerCell: UICollectionViewCell {
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

    var dis: Disclaimer? {
        didSet {
            guard let dis = dis else { return }
            let tvc = TeamViewController()
            tvc.disclaimersModel.append(dis)
            repNameLabel.text = dis.Representative
            jobTitleRemarks.text = dis.PublicRemarks
            
            
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
        
        stack(repNameLabel,jobTitleRemarks,separatorView.withHeight(24),UIView(), spacing: 4, alignment: .center, distribution: .equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
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
extension DisclaimerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}



