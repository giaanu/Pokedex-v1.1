import Foundation
import Combine

@MainActor
class GlobalPokemonSearchViewModel: ObservableObject {

    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false

    func loadAllPokemons() async {
        guard pokemons.isEmpty else { return }

        isLoading = true
        pokemons = []

        for id in 1...1010 {
            do {
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                pokemons.append(pokemon)
            } catch {
                print("Error cargando Pokémon \(id)")
            }
        }

        isLoading = false
    }
}
