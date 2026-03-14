import SwiftUI

struct CharacterDetailView: View {
    @Bindable var character: CharacterEntry

    var body: some View {
        Form {
            Section("Name") {
                TextField("Character Name", text: $character.name)
            }

            Section("Background") {
                TextEditor(text: $character.backgroundNotes)
                    .frame(minHeight: 100)
            }

            Section("Personality") {
                TextEditor(text: $character.personalityNotes)
                    .frame(minHeight: 100)
            }

            Section("Motivation") {
                TextEditor(text: $character.motivationNotes)
                    .frame(minHeight: 100)
            }

            Section("Arc") {
                TextEditor(text: $character.arcNotes)
                    .frame(minHeight: 100)
            }

            Section("General Notes") {
                TextEditor(text: $character.generalNotes)
                    .frame(minHeight: 120)
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
