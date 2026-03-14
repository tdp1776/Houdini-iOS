enum AcknowledgementBank {
    static let items = [
        "Added.",
        "Noted.",
        "Stored.",
        "Catalogued.",
        "Saved.",
        "Recorded.",
        "Entry updated.",
        "Information logged.",
        "Understood.",
        "Done."
    ]

    static func next() -> String {
        items.randomElement() ?? "Added."
    }
}
