//
//  TosCellItem.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
import UIKit

class TosCell: UICollectionViewCell {
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
            
            repNameLabel.text = dis.Representative
            jobTitleRemarks.text = dis.PublicRemarks
        }
    }
    
//    let imageView = UIImageView(cornerRadius: 8)
//
//    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
//    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
//
//    let getButton = UIButton(title: "GET")
    
//    let separatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

//        imageView.backgroundColor = .purple
//        imageView.constrainWidth(constant: 64)
//        imageView.constrainHeight(constant: 64)
//
//        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
//        getButton.constrainWidth(constant: 80)
//        getButton.constrainHeight(constant: 32)
//        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        getButton.layer.cornerRadius = 32 / 2
        
//        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
//        stackView.spacing = 16
//        
//        stackView.alignment = .center
//        
//        addSubview(stackView)
//        stackView.fillSuperview()
//        
//        addSubview(separatorView)
//        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
    }
    func setupViews() {
           
           stack(imageView, repNameLabel,titleLabel,jobTitleRemarks,separatorView.withHeight(24),UIView(), spacing: 4, alignment: .center, distribution: .equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
       }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
