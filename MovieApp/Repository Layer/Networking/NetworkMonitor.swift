import UIKit
import Network

class NetworkMonitor {
    
    var connectionStatus: Bool!

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status

            if path.status == .satisfied {
                print("We're connected!")
                self?.connectionStatus = true
                self?.stopMonitoring()
            } else {
                print("No connection.")
                
                self?.connectionStatus = false
                self?.stopMonitoring()
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
    
    func checkConnectionStatus() async -> Bool {
        startMonitoring()
        if (connectionStatus == true) {
            return true
        } else {
            return false
        }
    }
}
