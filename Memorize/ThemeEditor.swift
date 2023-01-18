//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Benjamin Craig on 1/17/23.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @Environment(\.isPresented) private var isPresented
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                nameSection
                removeEmojiSection
                addEmojisSection
                cardCountSection
                colorSection
            }
            .navigationTitle(theme.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem() {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text:$theme.displayName)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            for e in emojis.filter({$0.isEmoji}) {
                if !theme.emojis.contains(String(e)) {
                    theme.emojis.append(String(e))
                }
            }
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = theme.emojis
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: { String($0) == emoji })
                                theme.numberOfPairs = min(theme.emojis.count, theme.numberOfPairs)
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    var cardCountSection: some View {
        Section(header: Text("Card Count")) {
            let minPairs = min(2, theme.emojis.count)
            Stepper("\(theme.numberOfPairs) pairs", value: $theme.numberOfPairs, in: minPairs...theme.emojis.count)
        }
    }
    
    @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var colorSection: some View {
        Section(header: Text("Color")) {
            ColorPicker("Theme Color", selection: $bgColor)
        }
        .onAppear {
            bgColor = Color(rgbaColor: theme.color)
        }
        .onDisappear() {
            theme.color = RGBAColor(color: bgColor)
        }
    }
}
