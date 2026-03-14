enum CatalogueType: String, Codable, CaseIterable, Identifiable {
    case books = "Books"
    case technology = "Technology"
    case future = "Future"

    var id: String { rawValue }
}
