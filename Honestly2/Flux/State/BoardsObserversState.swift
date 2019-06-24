import Foundation
import Combine

struct BoardsObserversState: FluxState {
    var boardsObserver: Cancellable? = nil
}
