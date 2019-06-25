import Foundation

func getMockStateJSON() -> Data {
    return try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "mockState", ofType: "json")!))
}
let mockBoards: [Board] = getMockStateJSON().deserialize()!
let mockBoardsState = BoardsState(boards: mockBoards)
let mockState = MainDispatcher.AppState(boardsState: mockBoardsState)
