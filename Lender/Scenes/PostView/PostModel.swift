//
//  PostModel.swift
//  Lender
//
//  Created by 이석원 on 2022/10/23.
//

import Foundation

struct PostModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title , message: message )
    }
    
}
