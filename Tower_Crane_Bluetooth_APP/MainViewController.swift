//
//  MainViewController.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController, BluetoothDelegate {
    
    var bluetooth: Bluetooth!
    @IBOutlet weak var SimulatorButton: UIButton!
    @IBOutlet weak var manualControlButton: UIButton!
    @IBOutlet weak var connectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manualControlButton.setTitleColor(UIColor.black, for: .disabled)
        SimulatorButton.setTitleColor(UIColor.black, for: .disabled)
        
        if bluetooth == nil {
            bluetooth = Bluetooth()
        }
        bluetooth.delegate = self
        if  bluetooth.connected {
            manualControlButton.isEnabled = true
            SimulatorButton.isEnabled = true
        }
        else{
            manualControlButton.isEnabled = false
            SimulatorButton.isEnabled = false
        }
    }
    @IBAction func connectBluetooth(_ sender: UIButton) {
        bluetooth.scanForBLEDevice()
    }
    
    func bluetoothConnected(_ connected: Bool) {
        manualControlButton.isEnabled = true
        SimulatorButton.isEnabled = true
        connectionLabel.text = "Connected"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ManualControlViewController
        {
            let vc = segue.destination as? ManualControlViewController
            vc?.bluetooth = bluetooth
        }
        if segue.destination is Simulator
        {
            let vc = segue.destination as? Simulator
            vc?.bluetooth = bluetooth
            let string = "6"
            let data = string.data(using: String.Encoding.utf8)!
            print(data)
            bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
        }
    }
    
}
