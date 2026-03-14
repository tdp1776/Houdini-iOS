enum ClarificationBank {
    static let items = [
        "Where should I place this?",
        "Is this a character detail?",
        "Should this be added to a chapter?",
        "Would you like a new entry created?",
        "Can you clarify where this belongs?",
        "Is this background or story event?",
        "Should this be catalogued under a character?",
        "Do you want this connected to a chapter?",
        "Is this part of a character arc?",
        "How should I categorize this?"
    ]

    static func next() -> String {
        items.randomElement() ?? "Where should I place this?"
    }
}
