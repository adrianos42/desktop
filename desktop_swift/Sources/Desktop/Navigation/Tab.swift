import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// An item displayed in a ``Tab`` view.
public struct TabItem: Identifiable {
    public let id: UUID
    public let title: String
    public let content: AnyView

    public init<Content: View>(title: String, @ViewBuilder content: () -> Content) {
        self.id = UUID()
        self.title = title
        self.content = AnyView(content())
    }
}

/// A simple tab container, mirroring the Flutter `Tab` navigation widget.
///
/// This is an initial implementation: it renders a horizontal row of tab
/// titles styled with the desktop theme, and shows the body of the selected
/// tab below.
public struct Tab: View {
    @Environment(\.desktopTheme) private var theme
    @State private var selectedID: UUID?

    private let items: [TabItem]

    public init(items: [TabItem]) {
        self.items = items
        self._selectedID = State(initialValue: items.first?.id)
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(items) { item in
                    tabButton(for: item)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .background(theme.colorScheme.background[4])
            Rectangle()
                .fill(theme.colorScheme.background[12])
                .frame(height: 1)
            ZStack {
                if let selected = items.first(where: { $0.id == selectedID }) {
                    selected.content
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func tabButton(for item: TabItem) -> some View {
        let isSelected = item.id == selectedID
        return Button(action: { selectedID = item.id }) {
            VStack(spacing: 4) {
                Text(item.title)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .foregroundColor(isSelected ? theme.colorScheme.primary[50]
                                                : theme.colorScheme.shade[80])
                Rectangle()
                    .fill(isSelected ? theme.colorScheme.primary[50] : Color.clear)
                    .frame(height: 2)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
#endif
