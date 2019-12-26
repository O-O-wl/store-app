//
//  Category.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/10.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation
import Then

// MARK: - Category

enum Category {
    case main
    case soup
    case side
}

// MARK: - Section

extension Category: Section {
    
    var index: Int {
        switch self {
        case .main: return 0
        case .soup: return 1
        case .side: return 2
        }
    }
    
    var title: String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌게"
        case .side: return "밑반찬"
        }
    }
    
    var description: String {
        switch self {
        case .main: return "한그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌게"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}

// MARK: - CaseIterable

extension Category: CaseIterable {}

// MARK: - Then

extension Category: Then {}

