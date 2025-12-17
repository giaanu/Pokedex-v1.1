import SwiftUI

struct WrapView<Item: Hashable, Content: View>: View {

    let items: [Item]
    let spacing: CGFloat
    let content: (Item) -> Content

    init(
        items: [Item],
        spacing: CGFloat = 8,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: calculateHeight())
    }

    // MARK: - Layout helpers

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                content(item)
                    .padding(.horizontal, spacing / 2)
                    .padding(.vertical, spacing / 2)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > geometry.size.width {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        width -= d.width
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        return result
                    }
            }
        }
    }

    private func calculateHeight() -> CGFloat {
        CGFloat((items.count / 3) + 1) * 40
    }
}
