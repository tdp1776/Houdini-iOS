import SwiftUI

struct ParsePreviewView: View {
    let items: [ParsedPreviewItem]
    let onCancel: () -> Void
    let onCommit: () -> Void

    var body: some View {
        NavigationStack {
            List(items) { item in
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title).font(.headline)
                    Text(item.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(item.commandType.rawValue.capitalized)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Capsule())
                }
            }
            .navigationTitle("Preview Cataloguing")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Catalogue", action: onCommit)
                }
            }
        }
    }
}
