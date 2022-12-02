//
//  ContentView.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["✈️","🛰️","🚛","🚒","🛵", "🩼", "A", "B", "C", "D", "E", "F", "G","!","?","&","|"]
    
    @State var emojiCount = 10
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .navigationTitle("Memorize")
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1
            {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button{
            if emojiCount < emojis.count
            {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }

}

struct CardView: View
{
    // state is an external var to
    @State var isFaceUp: Bool = false
    var content: String
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp
            {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else
            {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)

    }
}
