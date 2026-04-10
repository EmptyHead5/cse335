//
//  ContentView.swift
//  FinalProject
//
//  Created by zenanchang on 3/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var goToSecond = false
    @StateObject private var viewModel = EventsViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    Text("SunDevil Campus Navigator")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink{
                        FavoritesView(viewModel: viewModel)
                    }label: {
                        Image(systemName: "heart.fill")
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("ASU_Maroon"))
                HStack{
                    Text("Events Near You")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Button{
                        
                    }label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color("ASU_Maroon"))
                    }
                    
                }

                List {
                    ForEach(viewModel.events, id: \.id) { event in
                        NavigationLink {
                            EventDetailView(event: event, viewModel: viewModel)
                        } label: {
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: event.imageURL))
                                {image in
                                    image.resizable()
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 50, alignment: .center)
                                
                         
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(event.title)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(.headline)

                                    Text(event.startDate)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    Text(event.locations.isEmpty ? event.campus : event.locations)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.analyze()
                }
                Spacer()
            }
        }
    }
}


#Preview {
    ContentView()
}



