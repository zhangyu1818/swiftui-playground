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

    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
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
                .background(.ultraThinMaterial, in: CornerShape(corners: [.topLeft, .topRight], radius: 12))

            VStack {
                Divider()
                contentView
                    .padding()

            }.background(.ultraThinMaterial, in: CornerShape(corners: [.bottomLeft, .bottomRight], radius: 12))
        }
        .colorScheme(.dark)
    }
}
