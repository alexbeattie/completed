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
import SafariServices

    
class TeamViewController: UICollectionViewController, SFSafariViewControllerDelegate {
    
    let cellId = "cellId"
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    let closeButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "trending"), for: .normal)
           button.tintColor = .darkGray
           button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
           return button
       }()
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    @objc func handleMore() {
           settingsLauncher.showSettings()
       }
    var disclaimersModel = [Disclaimer]()
//
//    func fetchDisclaimer() {
//        TosService.shared.fetchDisclaimer { (disclaimers, error) in
//            if let error = error {
//                print("failed to fetch", error)
//            }
//            self.tosVC.disclaimers = self.disclaimersModel
//
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                }
//            }
//        }
    
    
    
    func setupNavBarButtons() {
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon-2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = moreButton
        navigationItem.rightBarButtonItem?.tintColor = .black
       }
    
    let layout = UICollectionViewFlowLayout()
    let tosVC = DisclaimerViewController()
    func setupBackBarButton() {
          let barBtn = UIBarButtonItem()
          barBtn.title = " "
          barBtn.tintColor = UIColor.black
          navigationItem.backBarButtonItem = barBtn
      }
    func showControllerForMap(setting: Setting) {
         setupBackBarButton()
         let mapVC = MapOfListings()
//        self.present(mapVC, animated: true)
         navigationController?.pushViewController(mapVC, animated: true)
         
    }
//    func showControllerForHelp(setting: Setting) {
//
//    //        let layout = UICollectionViewFlowLayout()
//    //        setupBackBarButton()
//    //        let aboutSherwoodVC = AboutSherwoodVC(collectionViewLayout: layout)
//            
//            let cVC = Contact()
//            navigationController?.pushViewController(cVC, animated: true)
//
//           // navigationController?.pushViewController(aboutSherwoodVC, animated: true)
//
//        
//        }
    func showControllerForWebsite(setting: Setting) {
         setupBackBarButton()
        guard let url = URL(string: "http://sherwoodrealestate.com/") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func showControllerForHelp(setting: Setting) {
//        fetchDisclaimer()
        let layout = UICollectionViewFlowLayout()
        let disc = DisclaimerViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(disc, animated: true)

        //        self.present(disc, animated: true)
//        switch setting.name {
//        case .termsPrivacy:
//            print("tos")
//            let layout = UICollectionViewFlowLayout()
//                    // navigationController?.pushViewController(tosVC, animated: true)
//            let dVC = DisclaimerViewController(collectionViewLayout: layout)
//            fetchDisclaimer()
//            navigationController?.pushViewController(dVC, animated: true)
//
//        case .sendFeedback:
//            print("sendFeed")
//        case .cancel:
//            print("cancelme")
//        }
            
        
//        if setting.name == .termsPrivacy {
//            print(setting)
//        } else
//           setting.name == .sendFeedback
//            print(setting)
//        } else {
//            setting.name == .cancel
//            return
//        }
//        switch setting.name {
//        case .termsPrivacy:
////            let cv = UICollectionView
//            let layout = UICollectionViewFlowLayout()
////            let vc = ToSViewController(collectionViewLayout:layout) as? ToSViewController
//            let vc = DisclaimerViewController(collectionViewLayout: layout)
//            self.present(vc, animated: true) {
//                return
//            }
////            navigationController?.pushViewController(vc, animated: true)
//
//
//        case .help,
//             .sendFeedback:
//            print("alex")
//        default:
//            return
//        }
//        fetchDataSherwood()
//        let dummySettingsViewController = UIViewController()
//        dummySettingsViewController.view.backgroundColor = UIColor.white
//        dummySettingsViewController.navigationItem.title = setting.name.rawValue
//        navigationController?.navigationBar.tintColor = UIColor.black
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if mode == .fullscreen {
//            setupCloseButton()
//            navigationController?.isNavigationBarHidden = true
//        } else {
//            collectionView.isScrollEnabled = false
//        }
        fetchDataSherwood()
        setUpNavBar()
        setupNavBarButtons()

        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
    }
    func setupCloseButton() {
          view.addSubview(closeButton)
          closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
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



