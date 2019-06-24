import Foundation
import Combine

struct BoardObserverActions {

    struct StartBoardsObserver: Action {
        init() {
            let observeKeywords: ObserveApiPublisher<[Keyword]> = APIService.keywords(.get).observe()
            _ = observeKeywords.map { keywords -> [Board] in
                return [Board(name: "Main", keywords: keywords)]
            }.sink { boards in
                MainDispatcher.shared.dispatch(action: BoardActions.SetBoards(boards: boards))
            }
            MainDispatcher.shared.dispatch(action: BoardObserverActions.SetBoardObserver(observer: observeKeywords))
        }
    }

    struct SetBoardObserver: Action {
        let observer: Cancellable
    }

    struct StopBoardsObserver: Action {

    }
}
