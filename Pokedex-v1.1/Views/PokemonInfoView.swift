import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {

            // 📟 Marco Pokédex
            Image("pokedex_screen_main")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack {

                // 🟨 PANTALLA BLANCA (zona fija)
                VStack(spacing: 12) {
                    
                    if let urlString =
                        pokemon.sprites.other?.officialArtwork?.front_default
                        ?? pokemon.sprites.front_default,
                       let url = URL(string: urlString) {
                        
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 160) // ✅ nunca sale del blanco
                        
                        Text("#\(pokemon.id)")
                            .foregroundColor(.black)

                        Text(pokemon.name.capitalized)
                            .font(.title.bold())
                            .foregroundColor(.black)

                    }
                }
                .frame(height: 400)       // 🔒 altura REAL del rectángulo blanco
                .frame(maxWidth: .infinity)
                .padding(.top, 155)       // 🔒 posición exacta del blanco

                Spacer()

                // 🟩 PANTALLA VERDE (zona fija)
                VStack {
                    HStack(spacing: 8) {
                        ForEach(pokemon.types, id: \.slot) { entry in
                            TypeChip(type: entry.type.name)
                        }
                    }
                }
                .frame(height: 130)        // 🔒 altura REAL del verde
                .frame(maxWidth: .infinity)
                .padding(.bottom, 135)    // 🔒 posición exacta del verde
            }
        }
    }
}

