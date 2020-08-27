//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-03.
//  Copyright © 2020 polyergy. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }

        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent

        // MARK: - Bonus Time

         var bonusTimeLimit: TimeInterval = 6

         private var faceUpTime: TimeInterval {
             if let lastFaceUpDate = self.lastFaceUpDate {
                 return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
             } else {
                 return pastFaceUpTime
             }
         }

         var lastFaceUpDate: Date?

         var pastFaceUpTime: TimeInterval = 0

         var bonusTimeRemaining: TimeInterval {
             max(0, bonusTimeLimit - faceUpTime)
         }

         var bonusRemaining: Double {
             (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
         }

         var hasEarnedBonus: Bool {
             isMatched && bonusTimeRemaining > 0
         }

         var isConsumingBonusTime: Bool {
             isFaceUp && !isMatched && bonusTimeRemaining > 0
         }

         private mutating func startUsingBonusTime() {
             if isConsumingBonusTime, lastFaceUpDate == nil {
                 lastFaceUpDate = Date()
             }
         }

         private mutating func stopUsingBonusTime() {
             pastFaceUpTime = faceUpTime
             self.lastFaceUpDate = nil
         }
    }

    private(set) var cards: Array<Card>

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { (idx) in cards[idx].isFaceUp }.only
        }

        set {
            for idx in cards.indices {
                cards[idx].isFaceUp = idx == newValue
            }
        }
    }

    mutating func choose(card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched else {
            return
        }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            self.cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }
}

extension MemoryGame {
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)

            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: (pairIndex * 2) + 1, content: content))
        }
        cards.shuffle()
    } 
}
