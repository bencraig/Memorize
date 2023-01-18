//
//  ThemeChooseView.swift
//  Memorize
//
//  Created by Benjamin Craig on 1/16/23.
//

import SwiftUI

struct ThemeChooseView: View {
    @ObservedObject var store: ThemeStore
    
    @State private var editMode: EditMode = .inactive
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink (destination: EmojiMemoryGameView(game:store.themeToGameMap[theme] ?? EmojiMemoryGame())) {
                        VStack (alignment: .leading) {
                            Text(theme.displayName)
                                .foregroundColor(Color(rgbaColor: theme.color))
                                .font(.largeTitle)
                            Text("\(getCardCountString(for: theme)) \(theme.emojis.joined())")
                                .lineLimit(1)
                                .font(.system(size:12))
                        }
                    }
                    .gesture(editMode == .active ? tapToOpenThemeEditor(for:theme) : nil)
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .sheet(item: $themeToEdit) {
                // update theme on dismiss only? bctodo
            } content: { theme in
                ThemeEditor(theme: $store.themes[theme])
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        // add new theme via editor
                        themeToEdit = store.addTheme()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size:17))
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    func getCardCountString(for theme: Theme) -> String {
        let themePairCount = theme.numberOfPairs
        if themePairCount == theme.emojis.count {
            return "All of"
        } else {
            return "\(themePairCount) pairs from"
        }
    }
    
    func tapToOpenThemeEditor(for theme: Theme) -> some Gesture {
        return TapGesture().onEnded {
            themeToEdit = store.themes[theme]
        }
    }
}

struct ThemeChooseView_Previews: PreviewProvider {
    static var previews: some View {
        let themeStore = ThemeStore()
        return ThemeChooseView(store: themeStore)
    }
}
