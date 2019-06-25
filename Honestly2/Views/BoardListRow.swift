import SwiftUI

struct BoardListRow : View {
    
    var board: Model

    var cardRectangle: some View {
        RoundedRectangle(cornerRadius: 8)
            .shadow(radius: 1, y: 1)
            .foregroundColor(.blue)
            .frame(
                width: UIScreen.main.bounds.width-40.0,
                height: 300,
                alignment: .center)
    }

    var titleText: some View {
        Text(board.title)
            .font(.title)
            .foregroundColor(Color.white)
    }

    var descriptionText: some View {
        Text(board.description)
            .font(.body)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.leading)
            .lineLimit(Int.max)
    }

    var body: some View {
        ZStack {
            cardRectangle
            HStack {
                VStack(alignment: .leading) {
                    titleText
                    descriptionText
                    Spacer()
                }.padding(.all, 14)
                Spacer()
            }
        }.padding([.leading, .trailing])
         .frame(width: UIScreen.main.bounds.width, height: 300)

    }

    struct Model: Identifiable {
        let id = UUID()
        let title: String
        let description: String

        static func adapt(from model: Board) -> Model {
            Model(
                title: model.name,
                description: model.keywords
                                    .sorted { $0.importance > $1.importance }
                                    .map { $0.text }
                                    .joined(separator: ", ")
            )
        }

        static func mapFrom(model: [Board]) -> [Model] {
            return model.map { adapt(from: $0) }
        }
    }
}

#if DEBUG
struct BoardListRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BoardListRow(board: .adapt(from: mockBoards[0]))
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 320))
    }
}
#endif
