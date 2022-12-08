//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(game.getTitle())
                Spacer()
                Text(game.getScore())
            }.font(.largeTitle)
             .padding(.horizontal)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth()))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .padding(1)
                        .aspectRatio(2/3, contentMode: .fill)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .padding(.horizontal)
            .foregroundColor(game.getThemeColor())
            Spacer()
            newGame
        }.foregroundColor(game.getThemeColor())
    }
    
    var newGame: some View {
        Button {
            game.newGame()
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
        if game.cards.count < 8 {
            return width / 4.8
        } else if game.cards.count < 17 {
            return width / 5.9
        } else {
            return width / 6.9
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
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
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale )
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20.0
        static let lineWidth: CGFloat = 3.0
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
