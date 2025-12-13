import Foundation
import Combine

@MainActor
class RegionPokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false

    func loadRegion(_ region: Region) async {
        isLoading = true
        pokemons = []

        for id in region.pokedexRange{
            if let pokemon = await fetchPokemon(id: id) {
                pokemons.append(pokemon)
            }
        }

        isLoading = false
    }

    private func fetchPokemon(id: Int) async -> Pokemon? {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            print("Error cargando Pokemon \(id): \(error)")
            return nil
        }
    } 
}
