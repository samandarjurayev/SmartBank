//
//  aa.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
   private let monitor = NWPathMonitor()
   private let queue = DispatchQueue(label: "Monitor")
     
    @Published var isActive = true
    @Published var isExpensive = false
    @Published var isConstrainted = false
    @Published var connectionType = NWInterface.InterfaceType.other

    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isActive = path.status == .satisfied
                self?.isExpensive = path.isExpensive
                self?.isConstrainted = path.isConstrained
                
                let connectionType: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self?.connectionType = connectionType.first(where: path.usesInterfaceType) ?? .other
            }
        }
        monitor.start(queue: queue)
    }
}
