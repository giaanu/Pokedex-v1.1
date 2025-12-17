import SwiftUI
import Combine
import Foundation

struct PokemonGridCard: View {

    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 8) {

            AsyncImage(url: pokemonImageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)
            } placeholder: {
                ProgressView()
                    .frame(height: 72)
            }

            Text(pokemon.name.capitalized)
                .font(.footnote.bold())
                .foregroundColor(.black)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.25))
        )
    }

    private var pokemonImageURL: URL? {
        if let url = pokemon.sprites.other?.officialArtwork?.front_default {
            return URL(string: url)
        }
        return nil
    }
}
