//
//  Money.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/3/24.
//

import Foundation

struct Money: Identifiable {
    
    enum Category: String {
        case study = "자기계발"
        case food = "식비"
        case house = "정기지출"
        case hobby = "취미"
        case deposit = "저축"
    }
    
    // 보라색 오류
    func test() {
        var nickname = "aaa"
        DispatchQueue.global().async {
            nickname = "bbb"
        }
        DispatchQueue.global().async {
            nickname = "ccc"
        }
        print(nickname)
    }
    
    let id = UUID()
    let amount: Int
    let product: String
    let category: Category
    
    var amountFormat: String {
        return String(amount.formatted()) + "원"
    }
}

// gcd >> 동시접근
// xcode compile error
enum Dummy {
    static let money = [
        Money(amount: 21700, product: "스타벅스", category: .food),
        Money(amount: 500000, product: "청년절망적금", category: .deposit),
        Money(amount: 9000, product: "선식당", category: .food),
        Money(amount: 27000, product: "클린코드", category: .study),
        Money(amount: 150000, product: "스키장", category: .hobby),
        Money(amount: 600000, product: "월세", category: .house),
        Money(amount: 68400, product: "통신비", category: .house),
        Money(amount: 7000, product: "교동짬뽕", category: .food),
        Money(amount: 6500, product: "쉬즈베이글", category: .food),
        Money(amount: 4700, product: "컴포즈커피", category: .food),
        Money(amount: 8800, product: "메가커피", category: .food),
        Money(amount: 100000, product: "주택청약", category: .house),
        Money(amount: 63900, product: "솥고집", category: .hobby),
        Money(amount: 1500, product: "스타벅스", category: .food),
        Money(amount: 7800, product: "스타벅스", category: .food),
    ]
}
