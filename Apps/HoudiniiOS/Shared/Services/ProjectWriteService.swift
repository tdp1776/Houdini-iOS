import Foundation
import SwiftData

@MainActor
struct ProjectWriteService {
    func apply(command: ParsedCommand, to project: Project, in context: ModelContext) -> String {
        switch command.type {
        case .character:
            let title = inferShortTitle(from: command.payload, fallback: "New Character")
            let entry = CharacterEntry(name: title, generalNotes: command.payload)
            entry.project = project
            project.characters.append(entry)
            project.updatedAt = .now
            context.insert(entry)
            return AcknowledgementBank.next()

        case .chapter:
            let nextIndex = (project.chapters.map(\.orderIndex).max() ?? 0) + 1
            let chapter = ChapterEntry(orderIndex: nextIndex, title: inferChapterTitle(from: command.payload, fallback: "Chapter \(nextIndex)"), summary: command.payload)
            chapter.project = project
            project.chapters.append(chapter)
            project.updatedAt = .now
            context.insert(chapter)

            if chapter.contentDocument == nil {
                let document = ContentDocument(title: chapter.title)
                document.project = project
                document.chapter = chapter
                chapter.contentDocument = document
                project.contentDocuments.append(document)
                context.insert(document)
            }

            return AcknowledgementBank.next()

        case .content:
            let entry = ContentDocument(title: "Content \(project.contentDocuments.count + 1)", bodyText: command.payload)
            entry.project = project
            project.contentDocuments.append(entry)
            project.updatedAt = .now
            context.insert(entry)
            return AcknowledgementBank.next()

        case .project:
            let newTitle = command.payload.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !newTitle.isEmpty else { return ClarificationBank.next() }
            project.title = newTitle
            project.updatedAt = .now
            return "Project updated."

        case .map:
            MapBuildService().rebuildCharacterMap(for: project, in: context)
            return "Character map regenerated."

        case .none:
            return ClarificationBank.next()
        }
    }

    private func inferShortTitle(from text: String, fallback: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return fallback }
        let words = trimmed.split(separator: " ").prefix(5)
        let title = words.joined(separator: " ")
        return title.isEmpty ? fallback : title
    }

    private func inferChapterTitle(from text: String, fallback: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.lowercased().hasPrefix("chapter") { return trimmed }
        return inferShortTitle(from: trimmed, fallback: fallback)
    }
}

