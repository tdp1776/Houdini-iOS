import SwiftUI

struct ChapterListView: View {
    let project: Project

    var body: some View {
        List {
            if project.chapters.isEmpty {
                ContentUnavailableView("No Chapters Yet", systemImage: "list.number")
            } else {
                ForEach(project.chapters.sorted(by: { $0.orderIndex < $1.orderIndex })) { chapter in
                    NavigationLink {
                        ChapterDetailView(chapter: chapter)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(chapter.title).font(.headline)
                            if !chapter.summary.isEmpty {
                                Text(chapter.summary)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(3)
                            }
                        }
                    }
                }
            }
        }
    }
}
