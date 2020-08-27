//
//  Cardify.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-19.
//  Copyright © 2020 polyergy. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    private(set) var rotation: Double    // rotation in degrees

    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    var isFaceUp: Bool {
        rotation < 90
    }

    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0, y: 1, z: 0))
    }

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
