//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-03.
//  Copyright © 2020 polyergy. All rights reserved.
//

import Foundation

class EmojiMemoryGame {
    private var model = EmojiMemoryGame.createMemoryGame()

    static func createMemoryGame() -> MemoryGame<String> {
        let emoji = ["👻", "😆", "👾", "🌯", "🍑"]
        return MemoryGame<String>(
            numberOfPairsOfCards: 2,
            cardContentFactory: { idx in emoji[idx] }
        )
    }

    // MARK: - Access to the Model

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    // MARK: - Intent(s)

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
