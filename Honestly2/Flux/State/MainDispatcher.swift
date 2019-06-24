import SwiftUI
import Combine

final class MainDispatcher: BindableObject  {

    static let shared = MainDispatcher()

    var didChange = PassthroughSubject<MainDispatcher, Never>()

    struct AppState {
        var boardsState: BoardsState
        var boardsObserverState: BoardsObserversState
    }

    private(set) var state: AppState

    init() {
        state = AppState(
            boardsState: BoardsState(),
            boardsObserverState: BoardsObserversState()
        )
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

let mockBoards: [Board] = [
    Board(
        name: "Main",
        keywords: """
            Nullam ligula libero, tempor id eleifend imperdiet, cursus eget purus. Vestibulum et odio feugiat, porta ligula sed, ultrices risus. Donec ac nulla dapibus, suscipit dui pellentesque, volutpat augue. Curabitur a sollicitudin purus. Suspendisse nibh nibh, ullamcorper id pulvinar et, mollis non orci. Phasellus tristique eget sapien vel bibendum. In hac habitasse platea dictumst. Vestibulum aliquet sem tellus, quis dapibus quam condimentum et. Nulla mattis turpis non placerat aliquet. Suspendisse eu blandit ipsum. Etiam volutpat augue eget risus luctus commodo. Integer porta ipsum vitae justo porta laoreet. Maecenas congue varius diam, sit amet ornare sapien sollicitudin eget. Etiam efficitur arcu ac urna viverra maximus. Vestibulum in varius leo. Aenean in nisi lacinia dui sodales laoreet laoreet sit amet ipsum.
        """.split(separator: " ").map { word in
            Keyword(text: String(word), importance: Int.random(in: 0...100))
        }
    ),
]
