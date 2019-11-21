//
//  BluetoothDelegate.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/18/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import Foundation

// Create the bluetooth delegate to call a function whenever the bluetooth is connected to a peripheral device
protocol BluetoothDelegate {
    func bluetoothConnected(_ connected: Bool)
}
