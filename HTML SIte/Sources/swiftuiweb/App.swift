import TokamakShim
import Foundation


@main
struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("Tokamak App") {
            MouseEventsView()
        }
    }
}

struct MouseEventsView: View {
  @State var position: CGPoint = .zero
  @State var isMouseButtonDown: Bool = false

  var body: some View {
    DynamicHTML(
      "div",
      ["style": "width: 200px; height: 200px; background-color: red;"],
      listeners: [
        "mousemove": { event in
          guard
            let x = event.offsetX.jsValue.number,
            let y = event.offsetY.jsValue.number
          else { return }

          position = CGPoint(x: x, y: y)
        },
        "mousedown": { _ in isMouseButtonDown = true },
        "mouseup": { _ in isMouseButtonDown = false },
      ]
    ) {
      Text("position is \(position), is mouse button down? \(isMouseButtonDown)")
    }
  }
}
