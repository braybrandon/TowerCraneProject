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
    
    var bluetooth: Bluetooth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func rotateCraneLeft(_ sender: UIButton) {
        let string = "0"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    
    @IBAction func rotateCraneRight(_ sender: UIButton) {
        let string = "1"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    @IBAction func magnetUp(_ sender: UIButton) {
        let string = "2"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    
    @IBAction func magnetDown(_ sender: UIButton) {
        let string = "3"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    
    @IBAction func magnetOn(_ sender: UIButton) {
        let string = "4"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    
    @IBAction func magnetOff(_ sender: UIButton) {
        let string = "5"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController
        {
            let vc = segue.destination as? MainViewController
            vc?.bluetooth = bluetooth
        }
    }
}

