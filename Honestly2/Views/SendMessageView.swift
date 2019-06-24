import Foundation

import SwiftUI

struct SendMessageView : View {

    @EnvironmentObject var store: MainDispatcher

    @Environment(\.isPresented) var isPresented
    @State var message = ""


    var textField: some View {
        TextField($message,
                  placeholder: Text("Tell me something"))
            .textFieldStyle(.roundedBorder)
            .listRowInsets(EdgeInsets())
            .padding()
            .frame(width: 300.0, height: 20.0)
    }

    var rightBarButtonItem: some View {
        Button(action: {
            self.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sendMessage()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.startObservingBoards()
                }
            }
        }) {
            Text("Done")
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                textField
                Spacer()
            }.navigationBarItems(trailing: rightBarButtonItem)
        }
    }

    func dismiss() {
        self.isPresented?.value = false
    }

    func startObservingBoards() {
        self.store.dispatch(action: BoardActions.GetBoards())
    }

    func sendMessage() {
        self.store.dispatch(action: BoardActions.SendMessage(message: Message(text: self.message), to: Board(name: "", keywords: [])))
    }
}

#if DEBUG
struct SendMessageView_Previews : PreviewProvider {
    static var previews: some View {
        SendMessageView().environmentObject(MainDispatcher())
    }
}
#endif

