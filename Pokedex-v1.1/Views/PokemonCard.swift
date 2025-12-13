import SwiftUI

struct PokemonCard: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 8) {

            if let urlString =
                pokemon.sprites.other?.officialArtwork?.front_default
                ?? pokemon.sprites.front_default,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            Text(pokemon.name.capitalized)
                .font(.headline)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
