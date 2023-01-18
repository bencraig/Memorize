//
//  Theme.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/6/22.
// Theme model

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    private(set) var id: Int
    var color : RGBAColor
    var displayName: String
    var emojis : [String] {
        didSet {
            if oldValue.count == 0 {
                // only shuffle when adding new default set
                emojis.shuffle()
            }
            if oldValue.count < 2 {
                let minBound = min(5, emojis.count)
                numberOfPairs = Int.random(in :minBound...emojis.count)
            }
        }
    }
    var numberOfPairs: Int
        
    init (id: Int)
    {
        self.id = id
        self.displayName = ""
        self.emojis = [String]()
        self.numberOfPairs = 0
        self.color = RGBAColor(red:0.5, green:0.5, blue:0.5, alpha:1)
    }
}
