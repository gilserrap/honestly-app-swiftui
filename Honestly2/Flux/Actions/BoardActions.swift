import Foundation
import Combine

enum BoardActions: Action {

    struct GetBoards: Action {

        let request: AnyPublisher<[Board], Never>?

        init() {
            let keywordsRequest: AnyPublisher<[Keyword], Never>? = try? APIService.keywords(.get).request()
            self.request = keywordsRequest?.map { keywords -> [Board] in
                return [Board(name: "Main", keywords: keywords)]
            }.eraseToAnyPublisher()
            _ = self.request.sink { boards in
                MainDispatcher.shared.dispatch(action: SetBoards(boards: boards))
            }
        }
    }

    struct SendMessage: Action {

        init(message: Message, to board: Board) {
            let sendMessageRequest: AnyPublisher<Data, Never>? = try? APIService.message(.post).request(with: message)
            _ = sendMessageRequest?.sink { _ in
                MainDispatcher.shared.dispatch(action: NotifyMessageSent(message: message, board: board))
            }
        }
    }

    struct SetBoards: Action {
        let boards: [Board]
    }

    struct NotifyMessageSent: Action {
        let message: Message
        let board: Board

        init(message: Message, board: Board) {
            self.message = message
            self.board = board
            MainDispatcher.shared.dispatch(action: BoardActions.GetBoards())
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                MainDispatcher.shared.dispatch(action: BoardActions.DismissMessageSent())
            }
        }
    }

    struct DismissMessageSent: Action {

    }
}
