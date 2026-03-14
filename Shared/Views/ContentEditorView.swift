import SwiftUI

struct ContentEditorView: View {
    @Bindable var document: ContentDocument

    var body: some View {
        VStack {
            TextEditor(text: $document.bodyText)
                .padding(8)
        }
        .navigationTitle(document.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
