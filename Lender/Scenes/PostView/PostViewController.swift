//
//  PostViewController.swift
//  Lender
//
//  Created by 이석원 on 2022/10/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PostViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PostViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                switch row {
                case 0 :
                    let cell = tv.dequeueReusableCell(withIdentifier: "TitleTextFieldCell", for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
                    
                    cell.selectionStyle = .none
                    cell.titleInputField.placeholder = data
                    cell.bind(viewModel.titleTextFieldCellViewModel)
                    return cell
                case 1 :
                    let cell = tv.dequeueReusableCell(withIdentifier: "PriceTextFieldCell", for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
                    
                    cell.selectionStyle = .none
                    cell.priceInputField.placeholder = data
                    cell.bind(viewModel.priceTextFieldCellViewModel)
                    return cell
                    
                case 2 :
                    let cell = tv.dequeueReusableCell(withIdentifier: "DetailWriteFormCell", for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
                    
                    cell.selectionStyle = .none
                    cell.contentInputView.text = data
                    cell.bind(viewModel.detailWriteFormCellViewModel)
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(to: self.rx.setAlert)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTaped) 
            .disposed(by: disposeBag)
        
        
    }
    
    private func attribute() {
        title = "글 게시하기"
        view.backgroundColor = .systemBackground
        
        submitButton.title = "게시"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        //Index row 0
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
        //Index row 1
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell")
        //Index reow 2
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)

extension Reactive where Base: PostViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(action)
            base.present(alertController, animated: true, completion: nil)
        }
    }
    
}
