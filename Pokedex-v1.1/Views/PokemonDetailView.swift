import SwiftUI

struct PokemonDetailView: View {

    // MARK: - Input
    let pokemon: Pokemon
    let onNextPokemon: () -> Void
    let onPreviousPokemon: () -> Void

    // MARK: - State
    @State private var selectedTab = 0
    @StateObject private var viewModel = PokemonDetailViewModel()
    @Environment(\.dismiss) private var dismiss

    // MARK: - Body
    var body: some View {
        PokedexBackground {
            ZStack {

                // ===== CONTENIDO PRINCIPAL =====
                VStack {
                    TabView(selection: $selectedTab) {

                        // INFO
                        PokemonInfoView(pokemon: pokemon)
                            .tag(0)

                        // STATS
                        PokemonStatsView(
                            pokemon: pokemon,
                            weaknesses: viewModel.weaknesses,
                            resistances: viewModel.resistances
                        )
                        .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    // INDICADOR DE PÁGINA
                    HStack(spacing: 8) {
                        Circle()
                            .fill(selectedTab == 0 ? .blue : .gray.opacity(0.4))
                            .frame(width: 8, height: 8)

                        Circle()
                            .fill(selectedTab == 1 ? .blue : .gray.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                    .padding(.bottom, 20)
                    .overlay(
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
                        .padding(.top, 16),
                        alignment: .topLeading
                    )

                }

                // ===== D-PAD OVERLAY =====
                VStack {
                    Spacer()

                    HStack {
                        DPadView { direction in
                            handleDPad(direction)
                        }
                        .frame(width: 120, height: 120)   // ⬅️ ajustá al tamaño real del D-Pad
                        .padding(.leading, 24)

                        Spacer()
                    }
                    .padding(.bottom, 90) // ⬅️ ajustá a tu layout
                }
            }
        }
        .task {
            await viewModel.loadDamageRelations(for: pokemon)
        }
    }

    // MARK: - D-PAD LOGIC
    private func handleDPad(_ direction: DPadDirection) {
        switch direction {

        case .right:
            withAnimation(.easeInOut) {
                selectedTab = 1
            }

        case .left:
            withAnimation(.easeInOut) {
                selectedTab = 0
            }

        case .down:
            onNextPokemon()

        case .up:
            onPreviousPokemon()
        }
    }
}
