//
//  BannerSectionCollectionViewCell.swift
//  Lender
//
//  Created by 이석원 on 2022/10/13.
//

import UIKit
import SnapKit

class BannerSectionCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    
       return imageView
    }()
    
    func setup() {
        setupLayout()
        
        imageView.backgroundColor = .lightGray 
    }
}

private extension BannerSectionCollectionViewCell{
    func setupLayout() {
        [ imageView ].forEach { addSubview($0)}
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
