//
//  ColorExtension.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/22.
//

import SwiftUI
 
extension Color {
    static let mauve = Color(hex: "dabfff");
    static let midiumPurple = Color(hex: "907ad6");
    static let purpleNavy = Color(hex: "4f518c");
    static let spaceCadet = Color(hex: "2c2a4a");
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
