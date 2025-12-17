import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            PokedexBackground {
                RegionListView()
            }
        }
    }
}
