import SwiftUI

struct ChapterDetailView: View {
    @Bindable var chapter: ChapterEntry

    var body: some View {
        Form {
            Section("Title") {
                TextField("Chapter Title", text: $chapter.title)
            }

            Section("Summary") {
                TextEditor(text: $chapter.summary)
                    .frame(minHeight: 120)
            }

            Section("Notes") {
                TextEditor(text: $chapter.notes)
                    .frame(minHeight: 140)
            }

            if let document = chapter.contentDocument {
                Section {
                    NavigationLink("Open Writing Editor") {
                        ContentEditorView(document: document)
                    }
                }
            }
        }
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
