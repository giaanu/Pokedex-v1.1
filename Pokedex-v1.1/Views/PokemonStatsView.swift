import SwiftUI

struct PokemonStatsView: View {

    let pokemon: Pokemon
    let weaknesses: [String]
    let resistances: [String]

    @State private var animateStats = false

    var body: some View {

        ZStack(alignment: .top) {

            VStack(spacing: 0) {

                // ===== STATS BASE (ANCLADAS) =====
                statsSection
                    .padding(.top, 110)     // 🔒 alineado con la línea negra
                    .padding(.horizontal, 24)

                Spacer(minLength: 40)

                // ===== DEBILIDADES =====
                ChipSection(
                    title: "DEBILIDADES",
                    titleColor: .red.opacity(0.85),
                    items: weaknesses,
                    animate: animateStats
                )
                .padding(.top, 30)

                // ===== RESISTENCIAS =====
                ChipSection(
                    title: "RESISTENCIAS",
                    titleColor: .green,
                    items: resistances,
                    animate: animateStats
                )
                .padding(.top, 20)

                Spacer(minLength: 60)
            }
        }
        .onAppear {
            animateStats = true
        }
    }

    // MARK: - STATS BLOCK

    private var statsSection: some View {
        VStack(spacing: 14) {

            Text("STATS BASE")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)

            ForEach(Array(pokemon.stats.enumerated()), id: \.element.stat.name) { index, stat in
                StatRow(
                    name: statLabel(stat.stat.name),
                    value: stat.base_stat,
                    animate: animateStats,
                    delay: Double(index) * 0.08
                )
            }
        }
    }

    // MARK: - Helpers

    private func statLabel(_ raw: String) -> String {
        switch raw {
        case "hp": return "HP"
        case "attack": return "ATTACK"
        case "defense": return "DEFENSE"
        case "special-attack": return "SPECIAL ATTACK"
        case "special-defense": return "SPECIAL DEFENSE"
        case "speed": return "SPEED"
        default: return raw.uppercased()
        }
    }
}
