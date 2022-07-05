//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/07/05.
//

import UIKit
 
// 뷰에 필요한 것들만 선언
struct PaymentMethodViewModel {
  let name: String
  let digits: String
  let color: UIColor
  
  init(_ paymentMethod: PaymentMethod) {
    name = paymentMethod.name
    digits = "**** \(paymentMethod.digits)"
    color = UIColor(hex: paymentMethod.color) ?? .systemGray2
  }
}
