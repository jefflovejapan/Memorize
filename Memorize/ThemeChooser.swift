//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-09-16.
//  Copyright © 2020 polyergy. All rights reserved.
//

import SwiftUI

struct Theme: Identifiable {
    var id = UUID()
    var name: String
    var emojis: [String]
    var color: Color
}

struct ThemeChooser: View {
    @ObservedObject var themeStore: ThemeStore
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme)), label: { Text(theme.name) })
                }
            }
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser(themeStore: ThemeStore())
    }
}
