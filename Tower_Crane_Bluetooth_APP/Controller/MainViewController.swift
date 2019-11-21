//
//  MainViewController.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//  Purpose: The main View controller that is the initial view the user sees. Has 3 Buttons Simulator button, Manual control button, and connect Bluetooth button. When the simulator button is pressed the Simulator View is shown and the automation for the tower crane is ran. When the manual control button is pressed the manual control view is presented to the user allowing them to control the tower crane manually. Bluetooth connection button that allows the user to connect to the tower crane

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
        
        //checks to see if the phone is currently connected to the tower crane and if not then creates a bluetooth object.
        if bluetooth == nil {
            bluetooth = Bluetooth()
        }
    
        bluetooth.delegate = self
        
        //checks to see if the bluetooth is currently connected and enables the manual control button and simulator button if it is connected and disables them if its not
        if  bluetooth.connected {
            manualControlButton.isEnabled = true
            SimulatorButton.isEnabled = true
        }
        else{
            manualControlButton.isEnabled = false
            SimulatorButton.isEnabled = false
        }
    }
    
    // When the connect bluetooth button is pressed calls the scanForBLEDevice method to scan for the tower crane and connect to the crane
    @IBAction func connectBluetooth(_ sender: UIButton) {
        bluetooth.scanForBLEDevice()
    }
    
    //func that is called by the bluetooth delegate whenever the bluetooth is connected and enables the manual control button and simulator button. Then changes the connection label to let the user know they are connected to the tower crane 
    func bluetoothConnected(_ connected: Bool) {
        manualControlButton.isEnabled = true
        SimulatorButton.isEnabled = true
        connectionLabel.text = "Connected"
    }

    //func that is called whenever the phone is about to transition to another viewcontroller. This function sets the bluetooth object in the other view controller to the current bluetooth object in this viewController so we dont loose the bluetooth data.
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
            bluetooth.sendData(string: string)
        }
    }
    
}
