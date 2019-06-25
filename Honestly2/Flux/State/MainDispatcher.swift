import SwiftUI
import Combine

final class MainDispatcher: BindableObject  {

    static let shared = MainDispatcher()

    var didChange = PassthroughSubject<MainDispatcher, Never>()

    struct AppState {
        var boardsState = BoardsState()
        var boardsObserverState =  BoardsObserversState()
    }

    private(set) var state: AppState

    init(state: AppState) {
        self.state = state
    }

    init() {
        state = AppState()
    }

    func dispatch(action: Action) {
        var state = self.state
        state.boardsState = BoardsReducer().reduce(state: state.boardsState, action: action)
        state.boardsObserverState = BoardsObserversReducer().reduce(state: state.boardsObserverState, action: action)
        self.state = state
        DispatchQueue.main.async {
            self.didChange.send(self)
        }
    }
}
