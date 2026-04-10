//
//  EventDetailVIew.swift
//  FinalProject
//
//  Created by zenanchang on 3/21/26.
//

import SwiftUI

struct EventDetailView: View {
    let event: ASUEvent
    @ObservedObject var viewModel: EventsViewModel
    @State private var showFavoriteAlert = false
    @State private var showOnlineAlert = false
    var body: some View {
        ScrollView {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: event.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .clipped()
                    .cornerRadius(8)
                    
                    Text(event.title)
                        .font(.system(size: 23, weight: .semibold))
                    
                    Text(event.startDate)
                        .font(.system(size: 18))
                    HStack {
                        if event.locations.lowercased() == "online" {
                            Button {
                                showOnlineAlert = true
                            } label: {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 23))
                            }
                            .alert("Notice", isPresented: $showOnlineAlert) {
                                Button("OK", role: .cancel) { }
                            } message: {
                                Text("This event is online, no location map available.")
                            }
                        } else {
                            NavigationLink {
                                EventMapView(viewModel: viewModel,event: event)
                            } label: {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 23))
                            }
                        }

                        Text(event.locations)
                    }
                    Divider()
                    
                    Button
                    {
                        viewModel.addToFavoriteEvents(event)
                        showFavoriteAlert = true
                    } label:{
                        Text("Add to favorite")
                    }
                    .alert("success",isPresented: $showFavoriteAlert) {
                        Button("OK", role: .cancel) { }
                      } message: {
                          Text("Added to favorites")
                    }
                    .buttonStyle(.borderedProminent)
                    Text(event.campus)
                        .padding()
                }
            }
        .toolbar()
        {
            ToolbarItem(placement: .principal)
            {
                Text("Event Details")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .semibold))
            }
            
        }
            #if os(iOS)
            .toolbarBackground(Color("ASU_Maroon"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            #endif
        
    }
}

#Preview
{
    ContentView()
}

