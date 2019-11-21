//
//  Simulator.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//  Purpose: View controller that displays a 3D animation to the screen while the Tower Crane is running its Automation software. Takes in input from the tower crane VIA Bluetooth and lets the user know what operation the tower crane is currently on. The user has the option to pause the tower cranes operation by hitting the stop button on the app. To resume operation the user taps the play button. To go back to the main screen the user taps the back button at the top left of the app.
//

import SceneKit
import SpriteKit
import CoreBluetooth

class Simulator: UIViewController, CBPeripheralDelegate, SCNSceneRendererDelegate {
    
    @IBOutlet weak var simulationView: SCNView!
    
    var scene: SCNScene!
    var bluetooth: Bluetooth!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentStep: UILabel!
    @IBOutlet weak var magnet: UILabel!
    
    //Function that is called when the view first appears to the screen
    override func viewDidLoad() {
        
        //sets the connectedPeripheral deligate to this view controller
        bluetooth.connectedPeripheral.delegate = self
        super.viewDidLoad()
        
        //creates a SCNScene to run a 3D animation of the Tower Crane
        scene = SCNScene(named: "art.scnassets/TowerCraneAnimation.dae")
        simulationView.backgroundColor = UIColor.gray
        
        //presents the 3D animation to the screen
        simulationView.present(scene, with: .fade(withDuration: 0.1), incomingPointOfView: nil, completionHandler: nil)
        
    }
    
    //Button function when the stop button is pressed sends a 7 to the tower crane to let the crane know to stop operation
    @IBAction func stopButton(_ sender: UIButton) {
        
        let string = "7"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
        statusLabel.text = "Crane Stopped"
    }
    
    //Button function when the resume button is pressed sends an 8 to the tower crane to let the crane know to resume operation if the crane is currently stopped
    @IBAction func resumeButton(_ sender: Any) {
        let string = "8"
        let data = string.data(using: String.Encoding.utf8)!
        print(data)
        bluetooth.connectedPeripheral.writeValue(data, for: bluetooth.writeCharacteristics, type: CBCharacteristicWriteType.withoutResponse)
        statusLabel.text = "Crane in Operation"
    }
    
    //function that is called autimatically from the peripheral deligate whenever the tower crane sends data to the user phone. Changes the opropriate label to display the current process the crane is performing.
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteric: CBCharacteristic, error: Error?) {
        let data = characteric.value
        let str = String(decoding: data!, as: UTF8.self)
        switch str {
        case "C":
            statusLabel.text = "Crane Operation Complete"
            break
        case "R":
            currentStep.text = "Rotating Right"
            break
        case "L":
            currentStep.text = "Rotating Left"
            break
        case "D":
            currentStep.text = "Dropping Magnet"
            break
        case "U":
            currentStep.text = "Raising Magnet"
            break
        case "M":
            magnet.text = "Magnet ON!"
            break
        default:
            magnet.text = "Magnet OFF"
            break
        }
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

