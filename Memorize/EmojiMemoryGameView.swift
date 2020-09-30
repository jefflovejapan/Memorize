//
//  EmojiMemoryGameView`.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-03.
//  Copyright © 2020 polyergy. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject private var viewModel: EmojiMemoryGame

    init(viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
            }
            .foregroundColor(.orange)
            Button(
                action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.newGameTapped()
                    }
            },
                label: { Text("New Game") })
            .padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            return self.body(for: geometry.size)
        }
    }

    @State private var animatedBonusRemaining: Double = 0

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (-animatedBonusRemaining * 360) - 90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (-card.bonusRemaining * 360) - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)

                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }


    // MARK: - Drawing constants

    let faceUpAngle = Angle(radians: 0)
    let faceDownAngle = Angle(radians: .pi)
    let cardRotationAxis: (CGFloat, CGFloat, CGFloat) = (x: 0, y: 1, z: 0)
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

