import Foundation

protocol Reducer {
    associatedtype StateType: FluxState
    func reduce(state: StateType, action: Action) -> StateType
}

