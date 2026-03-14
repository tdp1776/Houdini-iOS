import SwiftData

enum ProjectTab: String, CaseIterable, Identifiable {
    case characters = "Characters"
    case chapters = "Chapters"
    case maps = "Maps"
    case content = "Content"

    var id: String { rawValue }
}

@MainActor
final class ProjectDetailViewModel: ObservableObject {
    @Published var mode: AppMode = .otc
    @Published var inputText: String = ""
    @Published var selectedTab: ProjectTab = .characters
    @Published var parsePreviewItems: [ParsedPreviewItem] = []
    @Published var showingParsePreview = false

    private let parser = CommandParser()
    private let modeService = ConversationModeService()
    private let writeService = ProjectWriteService()
    private let parseService = LargeTextParseService()

    func submit(for project: Project, in context: ModelContext) {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if shouldUsePreview(trimmed) {
            let result = parseService.parse(trimmed)
            parsePreviewItems = result.items
            showingParsePreview = true
            return
        }

        process(trimmed, for: project, in: context)
    }

    func commitPreview(for project: Project, in context: ModelContext) {
        for item in parsePreviewItems {
            let command = ParsedCommand(type: item.commandType, payload: item.title, confidence: 0.8)
            _ = writeService.apply(command: command, to: project, in: context)
        }
        appendAssistantMessage("Preview items catalogued.", to: project, in: context)
        parsePreviewItems = []
        showingParsePreview = false
        inputText = ""
    }

    func cancelPreview() {
        parsePreviewItems = []
        showingParsePreview = false
    }

    private func process(_ text: String, for project: Project, in context: ModelContext) {
        mode = modeService.updateMode(current: mode, input: text)

        let userMessage = ConversationMessage(role: .user, body: text, modeAtTime: mode)
        userMessage.project = project
        project.messages.append(userMessage)
        context.insert(userMessage)

        let parsed = parser.parse(text)
        let response: String

        if parsed.type != .none {
            response = writeService.apply(command: parsed, to: project, in: context)
        } else if mode == .creative {
            response = "Creative mode active. I’m ready to think through it with you."
        } else {
            response = ClarificationBank.next()
        }

        appendAssistantMessage(response, to: project, in: context)
        project.updatedAt = .now
        inputText = ""
    }

    private func appendAssistantMessage(_ body: String, to project: Project, in context: ModelContext) {
        let message = ConversationMessage(role: .assistant, body: body, modeAtTime: mode)
        message.project = project
        project.messages.append(message)
        context.insert(message)
    }

    private func shouldUsePreview(_ text: String) -> Bool {
        text.contains("\n") || text.count > 220
    }
}
