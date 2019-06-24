import SwiftUI

struct Crouton: View {

    let text: String
    @Binding var show: Bool

    var body: some View {
        Text(text)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
            .scaleEffect(show ? 1: 0.5)
            .opacity(show ? 1 : 0)
            .animation(
                Animation
                    .spring(initialVelocity: 5)
                    .speed(2))
    }
}

#if DEBUG
struct Crouton_Previews : PreviewProvider {
    static var previews: some View {
        Crouton(text: "Crouton!", show: .constant(true))
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
#endif

