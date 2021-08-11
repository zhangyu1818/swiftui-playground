//
//  CornerShape.swift
//  CornerShape
//
//  Created by ZhangYu on 2021/8/10.
//

import SwiftUI

struct CornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}
