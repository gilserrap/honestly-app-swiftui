import SwiftUI

struct Board: Identifiable, Codable {
    var id = UUID()
    let name: String
    let keywords: [Keyword]
}
