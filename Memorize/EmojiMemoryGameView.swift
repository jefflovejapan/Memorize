//
//  EmojiMemoryGameView`.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-03.
//  Copyright © 2020 polyergy. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                .onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .foregroundColor(.orange)
        .animation(.default)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            return self.body(for: geometry.size)
        }
    }

    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .font(.system(size: fontSize(for: size)))
        .rotation3DEffect(card.isFaceUp ? faceUpAngle : faceDownAngle, axis: cardRotationAxis)
    }


    // MARK: - Drawing constants

    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let faceUpAngle = Angle(radians: 0)
    let faceDownAngle = Angle(radians: .pi)
    let cardRotationAxis: (CGFloat, CGFloat, CGFloat) = (x: 0, y: 1, z: 0)
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct More_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
