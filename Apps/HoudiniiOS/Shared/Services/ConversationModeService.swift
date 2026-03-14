import Foundation
struct ConversationModeService {
    private let exitPhrases = ["otc", "return to otc"]

    func updateMode(current: AppMode, input: String) -> AppMode {
        let normalized = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if exitPhrases.contains(normalized) {
            return .otc
        }

        if current == .otc, CreativeTriggerMatcher.phrases.contains(where: { normalized.contains($0) }) {
            return .creative
        }

        return current
    }
}
