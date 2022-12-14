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
            emojis = ["âī¸", "đ", "đ", "đī¸", "đ","đ","đ","đ","đ¸","đģ","đ","đ","đ","đ","đ","đ","đ","đī¸","đ˛","đ ","đ"]
        case Name.Sports:
            emojis = ["đ","đ","đ","đ¤ŋ","đââī¸","đī¸","đŖ","âšī¸ââī¸","âī¸","đŽ","đŗ","đ","đī¸","đ","âˇī¸"]
        case Name.Foods:
            emojis = ["đĨ","đŊ","đ§","đ","đ","đ","đ","đ","đ","đĨ","đĨŠ","đĢ","đŖ","đĨ§","đŋ"]
        case Name.Flags:
            emojis = ["đŗī¸", "đ´", "đ´ââ ī¸", "đ", "đĻđ¸", "đ§đ¸", "đĻđļ", "đ¨đĻ", "đĻđŊ", "đŽđ´", "đ§đļ", "đ¨đŽ", "đĢđŽ", "đ¯đĩ", "đšđ­", "đēđž", "đŋđŧ"]
        case Name.Smileys:
            emojis = ["đ", "đ", "đ", "đĨš", "đĨŗ", "đ¤Ŗ", "đ", "đ", "đĨ¸", "đ", "đĸ", "đĨĩ", "đĨļ", "đ­", "đ¤Š", "đ", "đĨ˛"]
        case Name.Animals:
            emojis = ["đļ", "đą", "đ­", "đš", "đ°", "đĻ", "đģ", "đŧ", "đģââī¸", "đ¨", "đ¯", "đĻ", "đŽ", "đˇ", "đŊ", "đ¸", "đĻ", "đĸ", "đĻ", "đĻ", "đĻ", "đ ", "đŦ", "đ", "đ"]
        }
        emojis.shuffle()
        
        color = colors.randomElement() ?? "Red"
    }
}
