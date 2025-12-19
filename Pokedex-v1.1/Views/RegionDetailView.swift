import SwiftUI

struct RegionDetailView: View {

    @Environment(\.dismiss) private var dismiss

    let region: Region
    @StateObject private var viewModel = RegionPokemonViewModel()

    // 👉 3 columnas
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {

        ZStack(alignment: .topLeading) {

            // 🔴 Fondo Pokédex
            PokedexBackground {

                VStack(spacing: 0) {

                    // 🔒 Espacio exacto hasta la línea negra
                    Spacer()
                        .frame(height: 110)

                    // Título de región
                    HStack {
                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text(region.name)
                                .font(.title.bold())
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                    // 🟦 Lista de Pokémon
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemons, id: \.id) { pokemon in
                                NavigationLink {
                                    PokemonDetailView(pokemon: pokemon,
                                    onNextPokemon: {},
                                    onPreviousPokemon: {}
                                    )
                                } label: {
                                    PokemonGridCard(pokemon: pokemon)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                    }
                    .scrollIndicators(.hidden)
                }
            }

            // ⬅️ BOTÓN BACK (SIEMPRE VISIBLE)
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.9))
                    )
            }
            .padding(.leading, 20)
            .padding(.top, 16)
            .zIndex(10)
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadRegion(region)
        }
    }
}
