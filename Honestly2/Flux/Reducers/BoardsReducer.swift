import Foundation

struct BoardsReducer: Reducer {

    func reduce(state: BoardsState, action: Action) -> BoardsState {

        var state = state

        switch action {
        case let action as BoardActions.SetBoards:
            state.boards = action.boards
        case is BoardActions.NotifyMessageSent:
            state.showMessageSent = true
        case is BoardActions.DismissMessageSent:
            state.showMessageSent = false
        default:
            break
        }
        return state
    }
}
