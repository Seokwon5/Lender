//
//  PostViewModel.swift
//  Lender
//
//  Created by 이석원 on 2022/10/23.
//

import Foundation
import RxCocoa
import RxSwift

struct PostViewModel {
    let titleTextFieldCellViewModel = TitleTextFieldCellViewModel()
    let priceTextFieldCellViewModel = PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    //ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert : Signal<Alert>
    
    //View -> ViewModel
    let submitButtonTaped = PublishRelay<Void>()
    
    init(model: PostModel = PostModel()) {
        let title = Observable.just("글 제목")
        let price = Observable.just("₩ 비용 (선택사항)")
        let detail = Observable.just("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest(title, price, detail) { [$0, $1, $2] }
            .asDriver(onErrorJustReturn: [])
        
        let titleMessage = titleTextFieldCellViewModel
            .titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 제목을 입력해 주세요."] : [] }
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용을 입력해 주세요."] : [] }
        
        let errorMessage = Observable
            .combineLatest(
                titleMessage,
                detailMessage
            ) { $0 + $1 }
        
        self.presentAlert = submitButtonTaped
            .withLatestFrom(errorMessage)
            .map(model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        
    }
}
