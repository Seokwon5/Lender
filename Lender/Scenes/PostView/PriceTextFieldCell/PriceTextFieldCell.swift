//
//  PriceTextFieldCell.swift
//  Lender
//
//  Created by 이석원 on 2022/10/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let priceInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        contentView.addSubview(priceInputField)
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
