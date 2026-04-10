//
//  FavoritesView.swift
//  FinalProject
//
//  Created by zenanchang on 3/22/26.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: EventsViewModel

    var favoriteEvents: [ASUEvent] {
        viewModel.events.filter { viewModel.favoriteEventIDs.contains($0.id) }
    }

    var body: some View {
        VStack {
            Text("Favorites")
                .font(.title)
                .bold()

            List{
                ForEach(favoriteEvents,id: \.id){ event in
                    NavigationLink(
                        destination: EventDetailView(event: event, viewModel: viewModel)
                    ) {
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                            Text(event.startDate)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.removeFavoriteEvents(event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
