//
//  ContentView.swift
//  SoundVisualizer
//
//  Created by Brandon Baars on 1/22/20.
//  Copyright © 2020 Brandon Baars. All rights reserved.
//

import SwiftUI

let numberOfSamples: Int = 10

struct ContentView: View {
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarView: View {
    var value: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
    }
}
