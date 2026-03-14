import SwiftUI

struct InputBarView: View {
    @Binding var text: String
    let onSend: () -> Void

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Start Writing:Ideas,(People Places and Things)", text: $text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5...12)
                .frame(minHeight: 120)

            Button("Send", action: onSend)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.thinMaterial)
    }
}
