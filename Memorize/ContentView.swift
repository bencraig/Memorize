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
        NavigationStack {
            VStack(alignment: .center) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundColor(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
                Spacer()
                HStack {
                    transportation
                    Spacer()
                    sports
                    Spacer()
                    food
                }
                .font(.largeTitle)
                .padding(.horizontal)
            }
            .navigationTitle("Memorize!")
            .font(.largeTitle)
        }
    }
    
    var transportation: some View {
        Button {
//            randomizeEmojis()
//            emojis = ["✈️", "🚙", "🚎", "🏎️", "🚜","🚐","🚒","🚁","🛸","🛻","🚛","🚑","🚘","🚖","🚔","🚕","🚗","🏍️","🚲","🚠","🚓"].shuffled()
        } label: {
            VStack {
                Image(systemName: "car.circle")
                Text("Transportation")
                    .font(.body)
            }
        }
    }
    
    var sports: some View {
        Button {
//            randomizeEmojis()
//            emojis = ["🏀","🏈","🏓","🤿","🏄‍♂️","🏋️","🎣","⛹️‍♂️","♟️","🎮","🎳","🏇","🏌️","🏂","⛷️"].shuffled()
        } label: {
            VStack {
                Image(systemName: "figure.walk.circle")
                Text("Sport")
                    .font(.body)
            }
        }
    }
    
    var food: some View {
        Button {
//            randomizeEmojis()
//            emojis = ["🥐","🌽","🧄","🍌","🍉","🍇","🍑","🍞","🍔","🥓","🥩","🫔","🍣","🥧","🍿"].shuffled()
        } label: {
            VStack {
                Image(systemName: "fork.knife.circle")
                Text("Food")
                    .font(.body)

            }
        }
    }
    
//    func widthToFit() -> CGFloat {
//        if emojiCount < 10
//        {
//            return UIScreen.main.bounds.size.width / 3.5
//        }
//        else {
//            return UIScreen.main.bounds.size.width / 4.7
//        }
//    }
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
