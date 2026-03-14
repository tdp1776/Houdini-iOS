struct CommandParser {
    func parse(_ input: String) -> ParsedCommand {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return .none }

        let lower = trimmed.lowercased()

        let slashMap: [(String, CommandType)] = [
            ("/character", .character),
            ("/chapter", .chapter),
            ("/map", .map),
            ("/content", .content),
            ("/project", .project)
        ]

        for (prefix, type) in slashMap {
            if lower.hasPrefix(prefix) {
                let payload = String(trimmed.dropFirst(prefix.count)).trimmingCharacters(in: .whitespacesAndNewlines)
                return ParsedCommand(type: type, payload: payload, confidence: 1)
            }
        }

        return .none
    }
}
