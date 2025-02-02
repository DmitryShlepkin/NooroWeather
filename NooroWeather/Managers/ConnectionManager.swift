//
//  ConnectionManager.swift
//  NooroWeather
//
//  Created by Dmitry Shlepkin on 2/1/25.
//

import Network
import Combine

protocol ConnectionManagable {
    var isConnected: Bool { get }
    var connectionPublisher: PassthroughSubject<Bool, Never> { get }
}

class ConnectionManager: ConnectionManagable, ObservableObject {

    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")

    let connectionPublisher = PassthroughSubject<Bool, Never>()
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isConnected = isConnected
            self?.connectionPublisher.send(isConnected)
        }
        networkMonitor.start(queue: workerQueue)
    }

}
