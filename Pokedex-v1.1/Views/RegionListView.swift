import SwiftUI

struct RegionListView: View{
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(Region.all) {region in 
                        NavigationLink {

                            Text("Pokedex de \(region.name)")
                        } label: {
                            RegionCard(region: region)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Regiones Pokemon")
        }
    }
}

struct RegionCard: View {
    let region: Region

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .fill(Color.blue.opacity(0.15))
            .frame(height: 120)
            .shadow(radius: 4)

            Text(region.name)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
}

