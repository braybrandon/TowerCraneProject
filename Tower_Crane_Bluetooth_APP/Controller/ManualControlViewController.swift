//
//  ViewController.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 10/19/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//  Purpose: This View controllers purpose is to provide a d-pad like controls to the user whenever the user selects manual control from the Main View controller. There are 6 buttons on this view that will rotate the crane left/right, lower and raise the magnet of the crane, and finally turn on and off the electro magnet.
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
    
    //  Button function that calls the bluetooth method to send a 0 to the tower crane letting it know to rotate the crane left
    @IBAction func rotateCraneLeft(_ sender: UIButton) {
        let string = "0"
        bluetooth.sendData(string: string)
    }
    
    // Button function that callss the bluetooth method to send a 1 to the tower crane letting it know to rotate the crane right
    @IBAction func rotateCraneRight(_ sender: UIButton) {
        let string = "1"
        bluetooth.sendData(string: string)
    }
    
    // Button function that calls the bluetooth method to send a 2 to the tower crane letting it know to raise the magnet
    @IBAction func magnetUp(_ sender: UIButton) {
        let string = "2"
        bluetooth.sendData(string: string)
    }
    
    // Button function that calls the bluetooth method to send a 3 to the tower crane letting it know to lower the magnet
    @IBAction func magnetDown(_ sender: UIButton) {
        let string = "3"
        bluetooth.sendData(string: string)
    }
    
    // Button function that calls the bluetooth method to send a 4 to the tower crane letting it know to turn the electromagnet on
    @IBAction func magnetOn(_ sender: UIButton) {
        let string = "4"
        bluetooth.sendData(string: string)
    }
    
    // Button function that calls the bluetooth method to send a 5 to the tower crane letting it know to turn the electromagnet off
    @IBAction func magnetOff(_ sender: UIButton) {
        let string = "5"
        bluetooth.sendData(string: string)
    }
    
    //func that is called whenever the phone is about to transition to another viewcontroller. This function sets the bluetooth object in the mainViewController to the current bluetooth object in this viewController so we dont loose the bluetooth data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController
        {
            let vc = segue.destination as? MainViewController
            vc?.bluetooth = bluetooth
        }
    }
}

