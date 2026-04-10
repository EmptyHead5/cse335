//
//  StudyView.swift

import SwiftUI




struct StudyView: View {
    let cards: [Card]
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex: Int = 0
    @State private var isFlipped: Bool = false
    @State private var isRandom: Bool = false
    @State private var shuffledCards: [Card] = []
    
    private var currentCard: Card {
        if isRandom {
            return shuffledCards[currentIndex]
        } else {
            return cards[currentIndex]
        }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                
                if cards.isEmpty {
                    VStack(spacing: 12) {
                        Text("Please create a card")
                        
                        Button("Back to Deck") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                else{
                    ZStack
                    {
                        VStack(spacing: 40){
                            Text(currentCard.question)
                                .opacity(isFlipped ? 0 : 1)
                                .font(.largeTitle)
                            
                            if isFlipped == false {
                                Text("Tap to review")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(12)
                                    .offset(y: 40)
                                
                            }
                            
                            Text(currentCard.answer)
                                .opacity(isFlipped ? 1 : 0 )
                                .font(.body)
                                .padding()
                            
                        }
                        .font(.body)
                        .frame(maxWidth: 350, minHeight: 140)
                        .background(currentCard.theme.background)
                        .onTapGesture {
                            withAnimation(.easeInOut)
                            {
                                isFlipped.toggle()
                            }
                        }
                    }
                    HStack{
                        Button {
                            if currentIndex > 0 {
                                currentIndex -= 1
                                isFlipped = false
                            }
                        }
                        label: {
                            Image(systemName: "arrow.left")
                        }.disabled(currentIndex <= 0)
                        
                        Button {
                            if currentIndex < cards.count - 1
                            {
                                currentIndex += 1
                                isFlipped = false
                            }
                            
                        } label: {
                            Image(systemName: "arrow.right")
                        }.disabled(currentIndex >= cards.count - 1)
                        
                        Button("Random order") {
                            isRandom = true
                            shuffledCards = cards.shuffled()
                            currentIndex = 0
                            
                        }
                        
                        if isRandom == true{
                            Button("Quit random order")
                            {
                                isRandom = false
                                shuffledCards = cards
                            }
                        }
                    }
                    }
                    // CODE HERE: Display current card’s question or answer, tappable to flip (ZStack, Text, tap gesture)
                    
                    // CODE HERE: Add buttons for previous and next cards (HStack, Button, disable)
                    
                    // CODE HERE: Add toggle button for random/sequential order
                }
                    .navigationTitle("Study Flashcards")
                    .onAppear {
                        shuffledCards = cards
                    }
            }
        }
    }






