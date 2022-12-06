//
//  ContentView.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(viewModel.getTitle())
                Spacer()
                Text(viewModel.getScore())
            }.font(.largeTitle)
             .padding(.horizontal)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth()))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .padding(1)
                        .aspectRatio(2/3, contentMode: .fill)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding(.horizontal)
            .foregroundColor(viewModel.getThemeColor())
            Spacer()
            newGame
        }.foregroundColor(viewModel.getThemeColor())
    }
    
    var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            VStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.largeTitle)
                Text("New Game")
                    .font(.body)
            }
        }
    }
    
    func cardWidth() -> Double {
        let width = UIScreen.main.bounds.width
        if viewModel.cards.count < 8 {
            return width / 4.8
        } else if viewModel.cards.count < 17 {
            return width / 5.9
        } else {
            return width / 6.9
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
