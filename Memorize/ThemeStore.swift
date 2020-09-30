//
//  ThemeStore.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-09-16.
//  Copyright © 2020 polyergy. All rights reserved.
//

import Foundation
import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes: [Theme] = [
        Theme(name: "Smilies", emojis: ["🧐", "🤪", "🤨", "😳", "😬", "🤗", "🥱"], color: Color.yellow),
        Theme(name: "Sea", emojis: ["🐙", "🐳", "🦑", "🦐", "🦈", "🦀", "🐠", "🐡"], color: Color.blue),
        Theme(name: "Animals", emojis: ["🦒", "🦏", "🐫", "🦓", "🐆", "🐅", "🐘", "🦍", "🐃"], color: Color.black),
        Theme(name: "Plants", emojis: ["🌲", "🌾", "🌴", "🌳", "🍀", "🌵", "🎋", "🌿"], color: Color.green)
    ]
}
