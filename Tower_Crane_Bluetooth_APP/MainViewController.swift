//
//  MainViewController.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController {

     var centralManager: CBCentralManager!
     var connectedPeripheral: CBPeripheral!
     var writeCharacteristics: CBCharacteristic!
     var enableControllers = false

    @IBOutlet weak var manualControlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manualControlButton.isEnabled = enableControllers
        if writeCharacteristics != nil {
            print("\(writeCharacteristics.uuid)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ManualControlViewController
        {
            let vc = segue.destination as? ManualControlViewController
            vc?.centralManager = centralManager
            vc?.connectedPeripheral = connectedPeripheral
            vc?.writeCharacteristics = writeCharacteristics
        }
        if segue.destination is Simulator
        {
            let vc = segue.destination as? Simulator
            vc?.centralManager = centralManager
            vc?.connectedPeripheral = connectedPeripheral
            vc?.writeCharacteristics = writeCharacteristics
            let string = "2"
                     let data = string.data(using: String.Encoding.utf8)!
            print(data)
                     connectedPeripheral.writeValue(data, for: writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
        }
    }

}
