struct ParsedCommand {
    let type: CommandType
    let payload: String
    let confidence: Double
    static let none = ParsedCommand(type: .none, payload: "", confidence: 0)
}
