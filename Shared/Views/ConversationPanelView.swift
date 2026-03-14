import SwiftUI

struct ConversationPanelView: View {
    let messages: [ConversationMessage]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(messages.sorted(by: { $0.createdAt < $1.createdAt })) { message in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.role.rawValue.capitalized)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(message.body)
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(message.role == .user ? Color.blue.opacity(0.12) : Color.gray.opacity(0.12))
                            )
                    }
                }
            }
            .padding()
        }
        .frame(maxHeight: 240)
    }
}
