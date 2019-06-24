import Combine
import SwiftUI

class ObserveApiPublisher<T: Codable>: Publisher, Cancellable {

    typealias Output = T
    typealias Failure = Never

    var timer: Cancellable?
    var lastRequest: Cancellable?
    let service: APIService

    init(service: APIService) {
        self.service = service
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {

        let onTimerFired: () -> () = {
            self.lastRequest = (try! self.service.request() as AnyPublisher<T, Never>).sink { _ = subscriber.receive($0) }
        }
        timer = Timer.publish(every: 10, on: RunLoop.main, in: .default)
            .autoconnect()
            .map { _ -> () in return }
            .sink(receiveValue: onTimerFired)
        _ = onTimerFired()
    }

    func cancel() {
        lastRequest?.cancel()
        timer?.cancel()
    }
}
