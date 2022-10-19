//
//  BorrowSectionViewCell.swift
//  Lender
//
//  Created by 이석원 on 2022/10/17.
//

import SnapKit
import UIKit

class BorrowSectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 70.0 }
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 7.0
        
       return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup() {
        setupLayout()
        
        titleLabel.text = "망치 구해요"
        locationLabel.text = "서울시 성북구 길음동"
        
    }
}

private extension BorrowSectionViewCell {
    func setupLayout() {
        [titleLabel, locationLabel, imageView ].forEach { addSubview($0)}
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(4.0)
            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(imageView.snp.height)
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(imageView.snp.trailing).offset(8.0)
            $0.top.equalTo(imageView.snp.top).inset(8.0)
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
    }
}
