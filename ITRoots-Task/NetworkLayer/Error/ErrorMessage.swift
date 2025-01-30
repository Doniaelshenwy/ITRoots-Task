//
//  ErrorMessage.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Foundation

struct ErrorMessage: LocalizedError, Decodable {
    var message: String?
    var errorType: ErrorMessageTypes?
    
    init(errorType: ErrorMessageTypes) {
        self.errorType = errorType
    }
}

enum ErrorMessageTypes: Decodable {
    case serverError
    case somethingWentWrong
    case modelNotCorrect
    
    var errorDescription: String {
        switch self {
        case .serverError:
            return "Unfortunitly Server error!, try again later".localize
        case .somethingWentWrong:
            return "There is error occured, try again later".localize
        case .modelNotCorrect:
            return "Entity is Wrong".localize
        }
    }
}
