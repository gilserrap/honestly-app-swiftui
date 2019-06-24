import Combine

struct BoardsObserversReducer: Reducer {

    func reduce(state: BoardsObserversState, action: Action) -> BoardsObserversState {

        var state = state

        switch action {
        case let action as BoardObserverActions.SetBoardObserver:
            state.boardsObserver?.cancel()
            state.boardsObserver = action.observer
        case is BoardObserverActions.StopBoardsObserver:
            state.boardsObserver?.cancel()
        default:
            break
        }
        return state
    }
}
