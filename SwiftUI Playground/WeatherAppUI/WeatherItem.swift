//
//  WeatherItem.swift
//  WeatherItem
//
//  Created by ZhangYu on 2021/8/14.
//

import MapKit
import SwiftUI

struct ForecastView: View {
    var time: String
    var info: String
    var image: String

    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)

            Image(systemName: image)
                .renderingMode(.original)
                .font(.title2)
                .frame(height: 30)

            Text(info)
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
    }
}

struct HoursItemView: View {
    var body: some View {
        StackView(
            titleView: {
                Label {
                    Text("每小时天气预报")
                        .foregroundStyle(.secondary)
                }
                icon: {
                    Image(systemName: "clock")
                }
            },
            contentView: {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 28) {
                        Group {
                            ForecastView(time: "现在", info: "29°", image: "cloud.sun.fill")
                            ForecastView(time: "下午5时", info: "28°", image: "cloud.sun.fill")
                            ForecastView(time: "下午6时", info: "27°", image: "cloud.sun.fill")
                            ForecastView(time: "下午7时", info: "27°", image: "cloud.fill")
                        }
                        Group {
                            ForecastView(time: "下午7:46", info: "日落", image: "sunset.fill")
                            ForecastView(time: "下午8时", info: "27°", image: "cloud.fill")
                            ForecastView(time: "下午9时", info: "27°", image: "cloud.fill")
                            ForecastView(time: "下午10时", info: "26°", image: "cloud.fill")
                        }
                        Group {
                            ForecastView(time: "下午11时", info: "25°", image: "cloud.fill")
                            ForecastView(time: "上午12时", info: "25°", image: "cloud.fill")
                            ForecastView(time: "上午1时", info: "24°", image: "cloud.fill")
                            ForecastView(time: "上午2时", info: "24°", image: "cloud.fill")
                        }
                        Group {
                            ForecastView(time: "上午3时", info: "24°", image: "cloud.fill")
                            ForecastView(time: "上午4时", info: "23°", image: "cloud.fill")
                            ForecastView(time: "上午5时", info: "23°", image: "cloud.fill")
                            ForecastView(time: "上午6时", info: "23°", image: "cloud.fill")
                        }
                        Group {
                            ForecastView(time: "上午6:29时", info: "日出", image: "sunrise.fill")
                            ForecastView(time: "上午7时", info: "23°", image: "cloud.fill")
                            ForecastView(time: "上午8时", info: "23°", image: "cloud.fill")
                            ForecastView(time: "上午9时", info: "24°", image: "cloud.fill")
                        }
                    }
                }
                .padding()
            }
        )
    }
}

struct AirQualityView: View {
    var body: some View {
        StackView(
            titleView: {
                Label {
                    Text("空气质量")
                        .foregroundStyle(.secondary)
                }
                icon: {
                    Image(systemName: "aqi.low")
                }
            },
            contentView: {
                VStack(alignment: .leading, spacing: 6) {
                    Text("41 - 优")
                        .font(.title2.bold())
                    Text("当前AQI（CN）为41。")
                    LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red, .purple]), startPoint: .leading, endPoint: .trailing)
                        .frame(height: 6)
                        .cornerRadius(3)
                }
                .padding(.top, 6)
                .padding([.horizontal, .bottom])
            }
        )
    }
}

struct TenDaysItem: View {
    var day: String
    var image: String
    var min: CGFloat
    var max: CGFloat
    var offset: CGFloat = 0
    var body: some View {
        HStack(spacing: 12) {
            Text(day)
                .frame(maxWidth: 60, alignment: .leading)
            Image(systemName: image)
                .renderingMode(.original)
                .padding(.horizontal)
            Text("\(Int(min))°")
                .foregroundStyle(.secondary)
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.tertiary)
                    .foregroundStyle(.white)
                GeometryReader { proxy in
                    Capsule()
                        .fill(.linearGradient(.init(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                        .foregroundStyle(.white)
                        .frame(width: max / 40 * proxy.size.width)
                        .offset(x: offset * proxy.size.width / 2)
                }
            }
            .frame(height: 4)
            Text("\(Int(max))°")
        }
        .font(.title3)
        .padding(.vertical, 8)
    }
}

struct TenDaysWeatherView: View {
    var body: some View {
        StackView(
            titleView: {
                Label {
                    Text("10日天气预报")
                        .foregroundStyle(.secondary)
                }
                icon: {
                    Image(systemName: "calendar")
                }
            },
            contentView: {
                VStack {
                    Group {
                        TenDaysItem(day: "今天", image: "cloud.fill", min: 24, max: 30, offset: 0.2)
                        Divider()
                        TenDaysItem(day: "周日", image: "cloud.rain.fill", min: 23, max: 29)
                        Divider()
                        TenDaysItem(day: "周一", image: "cloud.rain.fill", min: 23, max: 29)
                        Divider()
                        TenDaysItem(day: "周二", image: "cloud.bolt.rain.fill", min: 23, max: 28, offset: 0.1)
                        Divider()
                        TenDaysItem(day: "周三", image: "cloud.bolt.rain.fill", min: 23, max: 29, offset: 0.2)
                        Divider()
                    }
                    Group {
                        TenDaysItem(day: "周四", image: "cloud.bolt.rain.fill", min: 23, max: 30, offset: 0.1)
                        Divider()
                        TenDaysItem(day: "周五", image: "cloud.rain.fill", min: 23, max: 29, offset: 0.1)
                        Divider()
                        TenDaysItem(day: "周六", image: "cloud.bolt.rain.fill", min: 23, max: 32)
                        Divider()
                        TenDaysItem(day: "周日", image: "cloud.bolt.rain.fill", min: 23, max: 30, offset: 0.2)
                        Divider()
                        TenDaysItem(day: "周一", image: "cloud.rain.fill", min: 23, max: 28)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
        )
    }
}

struct MapWeatherView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 30.65984,
            longitude: 104.10194
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    var body: some View {
        StackView(
            titleView: {
                Label {
                    Text("空气质量地图")
                        .foregroundStyle(.secondary)
                }
                icon: {
                    Image(systemName: "aqi.low")
                }
            },
            contentView: {
                Map(coordinateRegion: $region)
                    .cornerRadius(12)
                    .frame(height: 200)
                    .padding()
            }
        )
    }
}
