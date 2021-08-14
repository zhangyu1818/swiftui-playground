//
//  WeatherHomeView.swift
//  WeatherHomeView
//
//  Created by ZhangYu on 2021/8/10.
//

import SpriteKit
import SwiftUI

struct WeatherView: View {
    var body: some View {
        GeometryReader { proxy in
            let topEdge = proxy.safeAreaInsets.top

            WeatherHomeView(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct WeatherHomeView: View {
    @State var offset: CGFloat = 0

    var topEdge: CGFloat = 0

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image("weather").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)

            SpriteView(scene: Rain(), options: [.allowsTransparency])

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .center, spacing: 5) {
                        ZStack {
                            Text("成都市")
                                .font(.largeTitle)
                                .shadow(radius: 5)
                            Text("27° | 大部晴朗")
                                .font(.title3)
                                .fontWeight(.medium)
                                .offset(y: 35)
                                .opacity(1 - getTitleOpacity())
                        }

                        Group {
                            Text("27°")
                                .font(.system(size: 96, weight: .thin))
                            Text("大部晴朗")
                                .font(.title3)
                            Text("最高32° 最低22°")
                                .font(.title3)
                        }
                        .shadow(radius: 5)
                        .opacity(getTitleOpacity())
                    }
                    .foregroundStyle(.white)
                    // 抵消，保持不动
                    .offset(y: -offset)
                    // 向下拉计算一个位移量
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())

                    VStack(spacing: 8) {
                        AirQualityView()
                        HoursItemView()
                        TenDaysWeatherView()
                        MapWeatherView()
                        HStack(spacing: 12) {
                            StackView(
                                titleView: {
                                    Label {
                                        Text("体感温度")
                                            .foregroundStyle(.secondary)
                                    }
                                    icon: {
                                        Image(systemName: "thermometer")
                                    }
                                },
                                contentView: {
                                    VStack(alignment: .leading) {
                                        Text("31°")
                                            .font(.largeTitle.bold())
                                        Spacer()
                                        Text("潮湿使人感觉更暖和。")
                                    }
                                    .padding()
                                }
                            )
                            StackView(
                                titleView: {
                                    Label {
                                        Text("湿度")
                                            .foregroundStyle(.secondary)
                                    }
                                    icon: {
                                        Image(systemName: "humidity")
                                    }
                                },
                                contentView: {
                                    VStack(alignment: .leading) {
                                        Text("61%")
                                            .font(.largeTitle.bold())
                                        Spacer()
                                        Text("目前露点温度为20°。")
                                    }
                                    .padding()
                                }
                            )
                        }
                    }
                    .overlay(
                        SpriteView(scene: RainFall(), options: [.allowsTransparency])
                            .offset(y: -10)
                            .offset(y: -(offset + topEdge) > 160 ? -(offset + (160 + topEdge)) : 0)
                    )
                    .padding(.top, topEdge)
                    .padding(.bottom, 300)
                }
                .padding(.top, 50 + topEdge)
                .padding([.horizontal, .bottom])
                .overlay(GeometryReader { proxy -> Color in

                    let minY = proxy.frame(in: .global).minY

                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return Color.clear
                })
            }
        }
    }

    func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }

    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = -offset / 160

            let newOffset = (progress <= 1.0 ? progress : 1) * 20

            return -newOffset
        }
        return 0
    }
}

struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

class Rain: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill

        anchorPoint = CGPoint(x: 0.5, y: 1)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "Rain.sks")!
        addChild(node)

        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

class RainFall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill

        let height = UIScreen.main.bounds.height
        anchorPoint = CGPoint(x: 0.5, y: (height - 5) / height)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "RainFall.sks")!
        addChild(node)

        node.particlePositionRange.dx = UIScreen.main.bounds.width - 30
    }
}
