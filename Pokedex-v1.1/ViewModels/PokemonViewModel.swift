//
//  PokemonViewModel.swift
//  Pokedex-v1
//
//  Created by Gianluca Zarrelli on 09/12/2025.
//
import Combine
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPokemon(name: String) async {
        isLoading = true
        errorMessage = nil
        
        // Normalizar el texto que ingresa el usuario
        let safeName = name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !safeName.isEmpty else {
            errorMessage = "Ingresá un nombre válido"
            isLoading = false
            return
        }
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(safeName)") else {
            errorMessage = "URL inválida"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // OPCIONAL: ver respuesta cruda para debug
            // print(String(data: data, encoding: .utf8)!)
            
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            
        } catch {
            print("ERROR →", error)
            errorMessage = "No se pudo cargar el Pokémon"
        }
        
        isLoading = false
    }
}
