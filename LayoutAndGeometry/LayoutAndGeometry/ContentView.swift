//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Helen Dempsey on 5/27/25.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("Hello, world!")
//                
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                Image(systemName: "person.circle")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("PAUL HUDSON")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                    .font(.largeTitle)
//                
//                Text("Hello, world!")
//            }
//        }
//    }
//}
//
//extension VerticalAlignment {
//    enum MidAccountAndName: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            context[.top]
//        }
//    }
//
//    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
//}

//struct ContentView: View {
//    var body: some View {
////        Text("Hello, world!")
////            .background(.red)
////            .position(x: 100, y: 100)
//        
////        Text("Hello, world!")
////            .position(x: 100, y: 100)
////            .background(.red)
//        
////        Text("Hello, world!")
////            .offset(x: 100, y: 100)
////            .background(.red)
//        
//        Text("Hello, world!")
//            .background(.red)
//            .offset(x: 100, y: 100)
//    }
//}

//struct ContentView: View {
//    var body: some View {
////        GeometryReader { proxy in
////            Image(systemName: "globe")
////                .resizable()
////                .scaledToFit()
////                .frame(width: proxy.size.width * 0.8)
////        }
//        
////        HStack {
////            Text("IMPORTANT")
////                .frame(width: 200)
////                .background(.blue)
////
////            Image(systemName: "globe")
////                .resizable()
////                .scaledToFit()
////                .containerRelativeFrame(.horizontal) { size, axis in
////                    size * 0.8
////                }
////        }
//        
////        GeometryReader { proxy in
////            Image(systemName: "globe")
////                .resizable()
////                .scaledToFit()
////                .frame(width: proxy.size.width * 0.8)
////                .frame(width: proxy.size.width, height: proxy.size.height)
////        }
//        
////        GeometryReader { proxy in
////            Text("Hello, World!")
////                .frame(width: proxy.size.width * 0.9)
////                .background(.red)
////        }
//        
//        VStack {
//            GeometryReader { proxy in
//                Text("Hello, World!")
//                    .frame(width: proxy.size.width * 0.9, height: 40)
//                    .background(.red)
//            }
//            .background(.green)
//
//            Text("More text")
//                .background(.blue)
//        }
//    }
//}

//struct OuterView: View {
//    var body: some View {
//        VStack {
//            Text("Top")
//            InnerView()
//                .background(.green)
//            Text("Bottom")
//        }
//    }
//}
//
//struct InnerView: View {
//    var body: some View {
//        HStack {
//            Text("Left")
//            GeometryReader { proxy in
//                Text("Center")
//                    .background(.blue)
//                    .onTapGesture {
//                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
//                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
//                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
//                    }
//            }
//            .background(.orange)
//            Text("Right")
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        OuterView()
//            .background(.red)
//            .coordinateSpace(name: "Custom")
//    }
//}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        let screenHeight = fullView.size.height
                        let normalizedPosition = max(0, min(1, minY / screenHeight))
                        let hue = normalizedPosition
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: hue, saturation: 0.8, brightness: 0.9))
                            .opacity({
                                let minY = proxy.frame(in: .global).minY
                                let fadeStart: CGFloat = 0
                                let fadeEnd: CGFloat = 200
                                let opacity = (minY - fadeStart) / (fadeEnd - fadeStart)
                                return max(0, min(1, opacity))
                            }())
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect({
                                let y = proxy.frame(in: .global).minY
                                let viewHeight = fullView.size.height
                                let scale = y / viewHeight * 1.5
                                return max(0.5, scale)
                            }())
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

//struct ContentView: View {
//    var body: some View {
////        ScrollView(.horizontal, showsIndicators: false) {
////            HStack(spacing: 0) {
////                ForEach(1..<20) { num in
////                    GeometryReader { proxy in
////                        Text("Number \(num)")
////                            .font(.largeTitle)
////                            .padding()
////                            .background(.red)
////                            .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
////                            .frame(width: 200, height: 200)
////                    }
////                    .frame(width: 200, height: 200)
////                }
////            }
////        }
//        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    Text("Number \(num)")
//                        .font(.largeTitle)
//                        .padding()
//                        .background(.red)
//                        .frame(width: 200, height: 200)
//                        .visualEffect { content, proxy in
//                            content
//                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                        }
//
//                }
//            }
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
//    }
//}

#Preview {
    ContentView()
}
