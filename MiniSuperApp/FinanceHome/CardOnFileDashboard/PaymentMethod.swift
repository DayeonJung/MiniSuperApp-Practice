//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/07/05.
//

import Foundation

struct PaymentMethod: Decodable {
  let id: String
  let name: String
  let digits: String
  let color: String
  let isPrimary: Bool
}
