//
//  DeckView.swift
//

import SwiftUI

// Displays card's contents for preview
struct CardView: View {
    let card: Card
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.question)
                .font(.title3)
                .fontWeight(.bold)
            Text(card.answer)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(card.theme.background)
        .cornerRadius(10)
    }
}

struct DeckView: View {
    @Binding var deck: Deck
    @State private var showingAddCardSheet: Bool = false
    @State private var newQuestion: String = ""
    @State private var newAnswer: String = ""
    @State private var newTheme: CardTheme = .blue
    
    var body: some View {
        NavigationStack {
            VStack {
               NavigationLink("Study Flashcards")
                {
                    StudyView(cards: deck.cards)
                }
                .buttonStyle(.borderedProminent)
                // CODE HERE: Add button to navigate to StudyView if cards exist
                
                List {
                    ForEach(deck.cards.indices, id: \.self) { index in
                        CardView(card: deck.cards[index])
                    }
                    // CODE HERE: Add delete cards functionality
                }
            }
            .navigationTitle(deck.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddCardSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingAddCardSheet) {
                NavigationStack {
                    Form()
                    {
                        Section(header: Text("Card info")){
                            TextField("Question",text: $newQuestion)
                            TextField("Answer",text: $newAnswer)
                            Section(header: Text("Theme")) {
                                Picker("Theme Color", selection: $newTheme) {
                                    ForEach(CardTheme.allCases, id: \.self) { theme in
                                        Text(theme.rawValue)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                    }
                    .navigationTitle("Add Card")
                    .toolbar
                    {
                        ToolbarItem(placement: .cancellationAction) {
                           Button("cancel")
                            {
                                showingAddCardSheet = false
                            }
                        }
                        ToolbarItem(placement:.confirmationAction)
                        {
                            Button("Save")
                            {
                                deck.cards.append(Card(question: newQuestion, answer: newAnswer, theme: newTheme))
                                showingAddCardSheet = false

                            }
                        }
                    }
                        
                            // CODE HERE: Using forms and sections ask user for information(question and answer)
                            //            and color theme. Use picker view and for each to select the color theme
                        }
                    }
                }
            }
        }



#Preview {
    ContentView()
}
