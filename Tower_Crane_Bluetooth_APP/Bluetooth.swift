//
//  Bluetooth.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/18/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import UIKit
import CoreBluetooth

class Bluetooth: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    //Sample peripheral UUID
    let BLUE_HOME_SERVICE = "FFE0"
    
    var delegate: BluetoothDelegate?
    
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral!
    
    //Sample Characteristic UUID
    let writeCharacteristic = "FFE1"
    var writeCharacteristics: CBCharacteristic!
    var turnOffSimulator = false
    var connected = false
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scanForBLEDevice() {
        print("Scanning for devices")
        centralManager.scanForPeripherals(withServices: [CBUUID(string: BLUE_HOME_SERVICE)], options: nil)
    }
    
    @IBAction func connectBluetoothButton(_ sender: UIButton) {
        scanForBLEDevice()
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if(peripheral.name != nil) {
            print("Found Peripheral name = \(peripheral.name!)")
        }
        else{
            print("Found a Peripheral with unkown name")
        }
        
        //Save a reference to the peripheral
        connectedPeripheral = peripheral
        centralManager.stopScan()
        centralManager.connect(connectedPeripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to the device!")
        
        connectedPeripheral.delegate = self
        
        connectedPeripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Service count = \(String(describing: peripheral.services?.count))")
        
        for service in peripheral.services! {
            print("Service = \(service)")
            let aService = service as CBService
            if service.uuid == CBUUID(string: BLUE_HOME_SERVICE) {
                
                //Discover characteristics for our service
                peripheral.discoverCharacteristics(nil, for: aService)
            }
        }
    }
    
    //function that is automatically called when the central manager discovers a characteristic from a peripheral
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        //looping through all the characteristics in the service to find the correct characteristic were looking for
        for characteristics in service.characteristics! {
            
            
            let aCharacteristic = characteristics as CBCharacteristic
            
            //checks if the current characteristic is the characteristic were looking for and assigns it to the writeCharacteristic variable
            if aCharacteristic.uuid == CBUUID(string: writeCharacteristic) {
                print("We found our write Characteristic \(aCharacteristic.uuid)")
                writeCharacteristics = aCharacteristic
                peripheral.setNotifyValue(true, for: writeCharacteristics)
                connected = true
                delegate?.bluetoothConnected(connected)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor: CBCharacteristic, error: Error?) {
        print("updated")
    }
    
    
    //Function that is autamatically called when the Central manager object is created
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        print("centralManagerDidUpdateState: started")
        
        //checking the state of the Central Manager whether the bluetooth is turned on or off
        
        switch central.state {
        case .poweredOff:
            print("Power is OFF")
            break
        case .resetting:
            print("Resetting")
            break
        case .poweredOn:
            print("Power is On")
            break
        case .unauthorized:
            print("Unauthorized")
        case .unsupported:
            print("Unsupported")
        default:
            print("Unknown")
            break
            
        }
        
    }
    
}


