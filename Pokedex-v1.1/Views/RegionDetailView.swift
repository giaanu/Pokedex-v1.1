import Combine
import SwiftUI
import Foundation

struct RegionDetailView: View {
    let region: Region
    @StateObject private var viewModel = RegionPokemonViewModel()
    

    var body: some View {
        VStack {

            if viewModel.isLoading {
                ProgressView("Cargando Pokemon...")
                    .padding()
            }

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 16){
                    ForEach(viewModel.pokemons, id: \.id) { pokemon in
                        PokemonCard(pokemon: pokemon)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(region.name)
        .task{
            await viewModel.loadRegion(region)
        }
    }
}
