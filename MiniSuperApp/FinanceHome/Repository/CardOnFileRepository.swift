//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/07/05.
//

import Foundation

// 서버로부터 받아온 카드 목록 데이터
protocol CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject  }
  
  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "1", name: "아무은행", digits: "4567", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "2", name: "신한은행", digits: "8901", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "3", name: "이런은행", digits: "2345", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "4", name: "저런은행", digits: "6789", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "1", name: "아무은행", digits: "4567", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "2", name: "신한은행", digits: "8901", color: "#f19a38ff", isPrimary: false)
  ])
}
