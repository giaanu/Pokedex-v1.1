import SwiftUI

struct RegionListView: View {

    var body: some View {
        ZStack(alignment: .top) {

            // 🔴 HEADER FIJO
            HStack {
                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("POKÉDEX")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)

                    Text("Seleccioná una región")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 80)          // 👈 BAJAMOS el header
            .padding(.horizontal, 20)
            .zIndex(1)

            // 🔵 LISTA SCROLLEABLE
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Region.all) { region in
                        NavigationLink {
                            RegionDetailView(region: region)
                        } label: {
                            RegionCard(region: region)
                        }
                    }
                }
                .padding(.top, 180)     // 👈 ARRANQUE REAL DE TARJETAS
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            .mask(
                Rectangle()
                    .padding(.top, 145) // 👈 LÍNEA NEGRA (CORTE)
                    .padding(.bottom, 70)
            )
        }
    }
}
