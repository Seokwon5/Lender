//
//  HomeViewController.swift
//  Lender
//
//  Created by 이석원 on 2022/10/12.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let bannerSectionView = BannerSectionView(frame: .zero)
        let borrowSectionView = BorrowSectionView(frame: .zero)
        
        
        [bannerSectionView, borrowSectionView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        Layout()
        
    }
}

private extension HomeViewController {
    func setupNavigationBar() {
        navigationItem.title = "Lender"
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = searchButton
    }
    func Layout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview() // 세로 스크롤
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
