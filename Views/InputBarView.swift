import SwiftUI

struct InputBarView: View {
    @Binding var text: String
    let onSend: () -> Void

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Enter command or conversation…", text: $text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...8)

            Button("Send", action: onSend)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.thinMaterial)
    }
}
