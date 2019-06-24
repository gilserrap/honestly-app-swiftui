import SwiftUI

struct BoardList : View {

    @EnvironmentObject var store: MainDispatcher

    var boardsList: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(store.state.boardsState.boards) { board in
                    NavigationButton(destination: BoardDetail(board: board).environmentObject(self.store), isDetail: true) {
                        BoardListRow(board: BoardListRow.Model.adapt(from: board))
                    }
                }
            }
        }
    }

    var crouton: some View {
        Crouton(
            text: "Message sent",
            show: $store.state.boardsState.showMessageSent
        ).padding(.bottom, 40)
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                boardsList
                crouton
            }
            .navigationBarTitle(Text("Boards"), displayMode: .large)
            .navigationBarItems(trailing:
                PresentationButton(
                    destination: SendMessageView().environmentObject(store),
                    label: { Text("Add") }
                )
            )
            .onAppear {
                self.store.dispatch(action: BoardObserverActions.StartBoardsObserver())
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        BoardList().environmentObject(MainDispatcher())
    }
}
#endif
