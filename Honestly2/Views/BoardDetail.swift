import SwiftUI

struct BoardDetail : View {

    let board: Board

    @EnvironmentObject var store: MainDispatcher

    var body: some View {
        List(board.keywords.sorted(by:{ $0.importance > $1.importance }).identified(by: \.text)) { keyword in
            Text(keyword.text)
        }
        .navigationBarTitle(Text(board.name), displayMode: .large)
        .onAppear {
            self.store.dispatch(action: BoardObserverActions.StopBoardsObserver())
        }
    }
}

#if DEBUG
struct BoardDetail_Previews : PreviewProvider {
    static var previews: some View {
        BoardDetail(board: mockBoards[0])
    }
}
#endif
