//
//  ViewController.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 10/19/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import UIKit
import CoreBluetooth

class ManualControlViewController: UIViewController {
    
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral!
    var writeCharacteristics: CBCharacteristic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if writeCharacteristics != nil {
            print("\(writeCharacteristics.uuid)")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    @IBAction func LightOFF(_ sender: UIButton) {
        let string = "0"
                 let data = string.data(using: String.Encoding.utf8)!
        print(data)
                 connectedPeripheral.writeValue(data, for: writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
 
    @IBAction func LightOn(_ sender: UIButton) {
        let string = "1"
                 let data = string.data(using: String.Encoding.utf8)!
        print(data)
                 connectedPeripheral.writeValue(data, for: writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController
        {
            let vc = segue.destination as? MainViewController
            vc?.centralManager = centralManager
            vc?.connectedPeripheral = connectedPeripheral
            vc?.writeCharacteristics = writeCharacteristics
            if writeCharacteristics != nil {
                vc?.enableControllers = true
            }
        }
    }
}

