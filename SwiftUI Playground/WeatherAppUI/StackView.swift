//
//  StackView.swift
//  StackView
//
//  Created by ZhangYu on 2021/8/10.
//

import SwiftUI

struct StackView<Title: View, Content: View>: View {
    var titleView: Title
    var contentView: Content

    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0

    init(@ViewBuilder titleView: @escaping () -> Title,
         @ViewBuilder contentView: @escaping () -> Content)
    {
        self.titleView = titleView()
        self.contentView = contentView()
    }

    var body: some View {
        VStack(spacing: 0) {
            titleView
                .font(.callout)
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                // 38的时候下面收了上去，title就要4方都有圆角才行
                .background(.ultraThinMaterial, in: CornerShape(corners: bottomOffset < 38 ? .allCorners : [.topLeft, .topRight], radius: 12))
                .zIndex(1)

            contentView
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial, in: CornerShape(corners: [.bottomLeft, .bottomRight], radius: 12))
                .offset(y: topOffset >= 160 ? 0 : topOffset - 160)
                .zIndex(0)
                .clipped()
                .opacity(getOpacity())
        }
        .colorScheme(.dark)
        .cornerRadius(12)
        .opacity(getOpacity())
        .offset(y: topOffset >= 160 ? 0 : -topOffset + 160)
        .background(
            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let maxY = proxy.frame(in: .global).maxY
                DispatchQueue.main.async {
                    self.topOffset = minY
                    self.bottomOffset = maxY - 160
                }
                return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: bottomOffset))
    }

    func getOpacity() -> CGFloat {
        if bottomOffset < 28 {
            let progress = bottomOffset / 28
            return progress
        }
        return 1
    }
}

struct CornerModifier: ViewModifier {
    var bottomOffset: CGFloat

    func body(content: Content) -> some View {
        if bottomOffset < 38 {
            content
        } else {
            content.cornerRadius(12)
        }
    }
}
