//
//  WeatherHomeView.swift
//  WeatherHomeView
//
//  Created by ZhangYu on 2021/8/10.
//

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

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .center, spacing: 5) {
                        Text("成都")
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)

                        Text("32°")
                            .font(.system(size: 45))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())

                        Text("局部多云")
                            .foregroundStyle(.primary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOffset())

                        Text("最高35° 最低24°")
                            .foregroundStyle(.primary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                    }
                    .offset(y: -offset)
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())

                    VStack(spacing: 8) {
                        StackView(titleView: {
                            Label {
                                Text("Hourly Forecast")
                            }
                            icon: {
                                Image(systemName: "clock")
                            }
                        }) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForecastView(time: "12 PM", celcius: 32, image: "sun.min")

                                    ForecastView(time: "1 PM", celcius: 32, image: "sun.min")

                                    ForecastView(time: "2 PM", celcius: 32, image: "sun.min")

                                    ForecastView(time: "3 PM", celcius: 32, image: "sun.min")

                                    ForecastView(time: "4 PM", celcius: 32, image: "sun.min")

                                    ForecastView(time: "5 PM", celcius: 32, image: "sun.min")
                                }
                            }
                        }
                    }
                }
                .padding(.top, 25 + topEdge)
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
        print(opacity)
        return opacity
    }

    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = offset / 120

            let newOffset = (progress <= 1.0 ? progress : 1) * 20

            return newOffset
        }
        return 0
    }
}

struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct ForecastView: View {
    var time: String
    var celcius: Int
    var image: String

    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)

            Image(systemName: image)
                .font(.title2)
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
                .frame(height: 30)

            Text("\(celcius)°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
