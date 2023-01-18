//
//  ThemeStore.swift
//  Memorize
//
//  Created by Benjamin Craig on 1/16/23.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes = [Theme]() {
        didSet {
            // create new game for modified theme and add it to the map
            for theme in themes {
                if !oldValue.contains(theme) {
                    themeToGameMap[theme] = EmojiMemoryGame(theme: theme)
                }
            }
            
            // remove old game and invalid mapping
            for key in themeToGameMap.keys {
                if !themes.contains(key) {
                    themeToGameMap[key] = nil
                }
            }

            storeInUserDefaults()
        }
    }
    private var userDefaultsKey: String {
        "ThemeStore:"
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
        let decodedPalettes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedPalettes
        }
    }

    var themeToGameMap = [Theme: EmojiMemoryGame]()
    
    init () {
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("Using default themes")
            for themeName in DefaultName.AllThemes() {
                var newTheme = Theme(id: themes.count)
                newTheme.displayName = themeName.rawValue
                newTheme.emojis = defaultEmojis(for: themeName)
                let color = defaultColors.randomElement()!
                newTheme.color = RGBAColor(color: color)
                themes.append(newTheme)
            }
        }
    }
    
    func addTheme () -> Theme {
        let newTheme = Theme(id: themes.count)
        themes.append(newTheme)
        return newTheme
    }
    
    enum DefaultName: String, CaseIterable, Codable {
        case Transportation, Sports, Foods, Flags, Smileys, Animals
        
        static func chooseRandom() -> DefaultName
        {
            DefaultName.allCases.randomElement()!
        }
        
        static func AllThemes() -> [DefaultName] {
            DefaultName.allCases
        }
    }
    
    func defaultEmojis(for name: DefaultName) -> [String] {
        var emojis = [String]()
        switch name {
        case DefaultName.Transportation:
            emojis = ["✈️", "🚙", "🚎", "🏎️", "🚜","🚐","🚒","🚁","🛸","🛻","🚛","🚑","🚘","🚖","🚔","🚕","🚗","🏍️","🚲","🚠","🚓"]
        case DefaultName.Sports:
            emojis = ["🏀","🏈","🏓","🤿","🏄‍♂️","🏋️","🎣","⛹️‍♂️","♟️","🎮","🎳","🏇","🏌️","🏂","⛷️"]
        case DefaultName.Foods:
            emojis = ["🥐","🌽","🧄","🍌","🍉","🍇","🍑","🍞","🍔","🥓","🥩","🫔","🍣","🥧","🍿"]
        case DefaultName.Flags:
            emojis = ["🏳️", "🏴", "🏴‍☠️", "🏁", "🇦🇸", "🇧🇸", "🇦🇶", "🇨🇦", "🇦🇽", "🇮🇴", "🇧🇶", "🇨🇮", "🇫🇮", "🇯🇵", "🇹🇭", "🇺🇾", "🇿🇼"]
        case DefaultName.Smileys:
            emojis = ["😀", "😁", "😆", "🥹", "🥳", "🤣", "😌", "😛", "🥸", "😕", "😢", "🥵", "🥶", "😭", "🤩", "😍", "🥲"]
        case DefaultName.Animals:
            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🦑", "🐢", "🦂", "🦖", "🦞", "🐠", "🐬", "🐙", "🐌"]
        }
        
        return emojis
    }
    
    private let defaultColors = [Color.red, Color.blue, Color.green, Color.yellow, Color.orange, Color.purple,
                                 Color.cyan, Color.pink, Color.teal, Color.indigo, Color.mint]
    
}
