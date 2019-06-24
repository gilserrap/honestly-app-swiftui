import Foundation
import Combine

struct BoardsState: FluxState, Codable {
    var boards: [Board] = []
    var showMessageSent = false
}
