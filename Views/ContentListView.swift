import SwiftUI

struct ContentListView: View {
    let project: Project

    var body: some View {
        List {
            if project.contentDocuments.isEmpty {
                ContentUnavailableView("No Content Yet", systemImage: "doc.text")
            } else {
                ForEach(project.contentDocuments.sorted(by: { $0.updatedAt > $1.updatedAt })) { document in
                    NavigationLink {
                        ContentEditorView(document: document)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(document.title).font(.headline)
                            Text(document.bodyText)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(4)
                        }
                    }
                }
            }
        }
    }
}
