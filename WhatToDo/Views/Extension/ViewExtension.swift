//
//  ViewExtension.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import SwiftUI
import Combine
import UIKit

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}

extension Date {
    static func -(recent: Date, previous: Date) -> (leftDay: Int, leftHour: Int, leftMinute: Int) {
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let leftDay = minute! / 1440
        let leftHour = (minute! % 1440) / 60
        let leftMinute = minute! % 60 + 1
        return (leftDay: leftDay, leftHour: leftHour, leftMinute: leftMinute)
    }
}

func leftTime(_ leftTime: (leftDay: Int, leftHour: Int, leftMinute: Int)) -> String {
    if leftTime.leftHour < 0 || leftTime.leftMinute < 0 {
        return ""
    }
    if leftTime.leftDay == 0 && leftTime.leftHour == 0 && leftTime.leftMinute == 0 {
        return ""
    }
    
    var text: String = "~ "
    
    if leftTime.leftDay > 0 {
        text.append("\(leftTime.leftDay)일 \(leftTime.leftHour)시간")
    }
    else if leftTime.leftHour > 0 {
        text.append("\(leftTime.leftHour)시간 \(leftTime.leftMinute)분")
    }
    else {
        text.append("\(leftTime.leftMinute)분")
    }
        
    return text
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
