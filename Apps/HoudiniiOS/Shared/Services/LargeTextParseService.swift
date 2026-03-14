import Foundation

struct ParsedPreviewItem: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let commandType: CommandType
}

struct LargeTextParseResult {
    let items: [ParsedPreviewItem]
}

struct LargeTextParseService {
    func parse(_ text: String) -> LargeTextParseResult {
        let lines = text
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        var items: [ParsedPreviewItem] = []

        for line in lines {
            let lower = line.lowercased()
            if lower.hasPrefix("chapter") {
                items.append(ParsedPreviewItem(title: line, detail: "Detected chapter candidate", commandType: .chapter))
            } else if line.split(separator: " ").count <= 8 {
                items.append(ParsedPreviewItem(title: line, detail: "Possible character or short note", commandType: .character))
            } else {
                items.append(ParsedPreviewItem(title: String(line.prefix(60)), detail: "Possible content", commandType: .content))
            }
        }

        return LargeTextParseResult(items: items)
    }
}
