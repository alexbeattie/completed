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
   
    var disclaim: DisclaimerModel? {
        didSet {
            
        }
    }
    let cellId = "cellId"
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    let leftRightMargin: CGFloat = 12.0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

       setUpNavBar()
//        setupNavBarButtons()
//        self.disclaimers = Disclaimer
        fetchDataSherwood()
        collectionView.register(DisclaimerCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.scrollDirection = .vertical
           }
        
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
//        cell.dis = disclaimers[indexPath.item]
        cell.dis = disclaimers[indexPath.item]
//        cell.widthConstraint.constant = collectionView.frame.size.width - 2.0

        // MARK:
       // without DID SET
       
       // let teamResult = teamResults[indexPath.item]

       // cell.bodyLabel.text = teamResult.Representative
       // cell.titleLabel.text = teamResult.JobTitle
       // cell.jobTitleRemarks.text = teamResult.PublicRemarks
       // cell.imageView.sd_setImage(with: URL(string: teamResult.imageUrl))

//        cell.dis = disclaimers[indexPath.item]
        cell.jobTitleRemarks.preferredMaxLayoutWidth = collectionView.frame.size.width - 12 - 12
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disclaimers.count
    }
    
}


class DisclaimerCell: UICollectionViewCell {
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
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
//    var widthConstraint: NSLayoutConstraint!

    var dis: Disclaimer? {
        didSet {
            guard let dis = dis else { return }
            
            let tvc = TeamViewController()
            
            tvc.disclaimersModel.append(dis)
//            let width = cell.frame.width
//            jobTitleRemarks.preferredMaxLayoutWidth =
//            repNameLabel.text = dis.Representative
            jobTitleRemarks.text = dis.PublicRemarks
//            textView.text = dis.PublicRemarks
//            textView.text = dis.PublicRemarks

            
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
//              let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
//              let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
//              let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
//              NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])

        backgroundColor = .white
    }
//    var isHeightCalculated: Bool = false
       
//       override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//          if !isHeightCalculated {
//               setNeedsLayout()
//               layoutIfNeeded()
//               let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//               var newFrame = layoutAttributes.frame
//               newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//               layoutAttributes.frame = newFrame
//               isHeightCalculated = true
//           }
//           return layoutAttributes
//       }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        stack(jobTitleRemarks, spacing: 0, alignment: .leading, distribution:.equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
//        stack(textView).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
}

extension DisclaimerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: 200)
        
        
//        let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
//        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
//        let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
//
//        return CGSize(width: view.frame.width, height: rect.height + 30)

    }
//    func descriptionAttributedText() -> NSAttributedString {
//        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 12
//        let range = NSMakeRange(0, attributedText.string.count)
//        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
//
//        if let desc =  {
//            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
//        }
//
//        return attributedText
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}



