//
//  ContentView.swift
//  TrueMasonaryStackExample
//
//  Created by Wit Owczarek on 29/11/2024.
//

import SwiftUI
import TrueMasonaryStack

typealias Rect = (size: CGSize, color: Color)

struct ContentView: View {
    @State private var rectangles: [Rect] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    MStack {
                        ForEach(0..<rectangles.count, id: \.self) { index in
                            Rectangle()
                                .fill(rectangles[index].color.gradient.secondary)
                                .cornerRadius(relativeCornerRadius(for: rectangles[index].size, with: geo))
                                .frame(
                                    width: rectangles[index].size.width,
                                    height: rectangles[index].size.height
                                )
                                .overlay {
                                    Text("\(index)")
                                        .foregroundStyle(.primary)
                                        .fontWeight(.semibold)
                                }
                        }
                    }
                    .onAppear(perform: generateRects)
                    .padding()
                    .ignoresSafeArea()
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Randomize", systemImage: "arrow.clockwise") {
                            generateRects()
                        }
                    }
                }
            }
        }
    }
    
    func relativeCornerRadius(for rect: CGSize, with geo: GeometryProxy, maxCornerRadius: CGFloat = 250) -> CGFloat {
        return (maxCornerRadius * rect.width * rect.height) / (geo.size.width * geo.size.height)
    }
    
    func generateRects() {
        var rects: [(CGSize, Color)] = []
        for _ in 0..<50 {
            let width: CGFloat = .random(in: 50..<250)
            let height: CGFloat = .random(in: 50..<250)
            let randomColor: Color = randomColor()
            let rect = Rect(size: CGSize(width: width, height: height), color: randomColor)
            rects.append(rect)
        }
        self.rectangles = rects
    }
    
    func randomColor() -> Color {
        let colors: [Color] = [
            .red,
            .blue,
            .green,
            .yellow,
            .orange,
            .purple,
            .pink,
            .gray,
            .cyan,
            .indigo,
            .mint,
            .teal
        ]
       return colors.randomElement() ?? .black
    }
}

#Preview {
    ContentView()
}
