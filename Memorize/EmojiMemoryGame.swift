//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-03.
//  Copyright © 2020 polyergy. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>

    let theme: Theme
    init(theme: Theme) {
        self.theme = theme
        self.model = MemoryGame(numberOfPairsOfCards: theme.emojis.count, cardContentFactory: { (idx) -> String in
            theme.emojis[idx]
        })
    }

    // MARK: - Access to the Model

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    // MARK: - Intent(s)

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func newGameTapped() {
        model = MemoryGame(numberOfPairsOfCards: theme.emojis.count, cardContentFactory: { idx in self.theme.emojis[idx] } )
    }
}
