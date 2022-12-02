//
//  ContentView.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis = ["✈️","🛰️","🚛","🚒","🛵", "🩼"]
    
    @State var emojiCount = 6
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: widthToFit()))]) {
                        ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
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
            randomizeEmojis()
            emojis = ["✈️", "🚙", "🚎", "🏎️", "🚜","🚐","🚒","🚁","🛸","🛻","🚛","🚑","🚘","🚖","🚔","🚕","🚗","🏍️","🚲","🚠","🚓"].shuffled()
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
            randomizeEmojis()
            emojis = ["🏀","🏈","🏓","🤿","🏄‍♂️","🏋️","🎣","⛹️‍♂️","♟️","🎮","🎳","🏇","🏌️","🏂","⛷️"].shuffled()
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
            randomizeEmojis()
            emojis = ["🥐","🌽","🧄","🍌","🍉","🍇","🍑","🍞","🍔","🥓","🥩","🫔","🍣","🥧","🍿"].shuffled()
        } label: {
            VStack {
                Image(systemName: "fork.knife.circle")
                Text("Food")
                    .font(.body)

            }
        }
    }
    
    func widthToFit() -> CGFloat {
        if emojiCount < 10
        {
            return UIScreen.main.bounds.size.width / 3.5
        }
        else {
            return UIScreen.main.bounds.size.width / 4.7
        }
    }
    
    func randomizeEmojis()
    {
        emojiCount = Int.random(in:8...15)
    }
}

struct CardView: View
{
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
        }.padding(/*@START_MENU_TOKEN@*/.all, 3.0/*@END_MENU_TOKEN@*/)
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
