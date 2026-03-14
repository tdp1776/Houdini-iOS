import SwiftUI

struct CharacterListView: View {
    let project: Project

    var body: some View {
        List {
            if project.characters.isEmpty {
                ContentUnavailableView("No Characters Yet", systemImage: "person.text.rectangle")
            } else {
                ForEach(project.characters.sorted(by: { $0.createdAt < $1.createdAt })) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(character.name).font(.headline)
                            if !character.generalNotes.isEmpty {
                                Text(character.generalNotes)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(3)
                            }
                        }
                    }
                }
            }
        }
    }
}
