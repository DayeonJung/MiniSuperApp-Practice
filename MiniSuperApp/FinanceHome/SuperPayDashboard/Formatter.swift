//
//  NumberFormatter.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/06/30.
//

import Foundation

struct Formatter {
  static let balanceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}
