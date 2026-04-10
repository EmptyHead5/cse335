import SwiftUI
import MapKit

struct ParkDetailView: View {
    let park: Park
    @StateObject private var viewModel = ParkViewModel()

    @State private var searchText = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(park.name)
                    .font(.title)
                    .bold()

                Text("Location: \(park.location)")

                Image(park.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)

                Map(coordinateRegion: $viewModel.region,
                    annotationItems: viewModel.markers) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                            Text(item.name ?? "")
                                .font(.caption)
                        }
                    }
                }
                .frame(height: 300)

                TextField("Search around", text: $searchText)
                    .textFieldStyle(.roundedBorder)

                Button("Search") {
                    viewModel.searchNearbyPlaces(searchText: searchText)
                }

                Text(viewModel.statusText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Text(park.description)
            }
            .padding()
        }
        .onAppear {
            viewModel.selectedPark = park
            viewModel.loadCurrentPark()
        }
    }
}

#Preview {
    ContentView()
}
