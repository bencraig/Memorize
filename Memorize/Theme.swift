//
//  Theme.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/6/22.
// Theme model

import Foundation

struct Theme {
    enum Name: String, CaseIterable {
        case Transportation, Sports, Foods, Flags, Smileys, Animals
        
        static func chooseRandom() -> Name
        {
            Name.allCases.randomElement()!
        }
    }
    
    private(set) var color : String
    private(set) var name : Name
    private(set) var emojis : [String]
    private let colors = ["Red", "Yellow", "Green", "Blue", "Purple", "Orange", "Cyan", "Pink", "Teal", "Indigo", "Brown", "Mint"]
    
    init (name: Name)
    {
        self.name = name
        switch name
        {
        case Name.Transportation:
            emojis = ["✈️", "🚙", "🚎", "🏎️", "🚜","🚐","🚒","🚁","🛸","🛻","🚛","🚑","🚘","🚖","🚔","🚕","🚗","🏍️","🚲","🚠","🚓"]
        case Name.Sports:
            emojis = ["🏀","🏈","🏓","🤿","🏄‍♂️","🏋️","🎣","⛹️‍♂️","♟️","🎮","🎳","🏇","🏌️","🏂","⛷️"]
        case Name.Foods:
            emojis = ["🥐","🌽","🧄","🍌","🍉","🍇","🍑","🍞","🍔","🥓","🥩","🫔","🍣","🥧","🍿"]
        case Name.Flags:
            emojis = ["🏳️", "🏴", "🏴‍☠️", "🏁", "🇦🇸", "🇧🇸", "🇦🇶", "🇨🇦", "🇦🇽", "🇮🇴", "🇧🇶", "🇨🇮", "🇫🇮", "🇯🇵", "🇹🇭", "🇺🇾", "🇿🇼"]
        case Name.Smileys:
            emojis = ["😀", "😁", "😆", "🥹", "🥳", "🤣", "😌", "😛", "🥸", "😕", "😢", "🥵", "🥶", "😭", "🤩", "😍", "🥲"]
        case Name.Animals:
            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🦑", "🐢", "🦂", "🦖", "🦞", "🐠", "🐬", "🐙", "🐌"]
        }
        emojis.shuffle()
        
        color = colors.randomElement() ?? "Red"
    }
}
