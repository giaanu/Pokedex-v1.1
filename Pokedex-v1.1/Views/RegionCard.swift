import SwiftUI

struct RegionCard: View {
    let region: Region

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(region.name.uppercased())
                    .font(.headline.bold())
                    .foregroundColor(.blue)

                Text("\(region.pokedexRange.lowerBound)–\(region.pokedexRange.upperBound)")
                    .font(.caption.bold())
                    .foregroundColor(.blue)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            // 👇 material sin bordes visibles
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .opacity(0.7)
        )
        .shadow(color: .black.opacity(0.18), radius: 6, x: 0, y: 3)
    }
}
