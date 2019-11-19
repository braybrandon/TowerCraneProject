//
//  Simulator.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
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
    
    override func viewDidLoad() {
        bluetooth.connectedPeripheral.delegate = self
        super.viewDidLoad()
        scene = SCNScene(named: "art.scnassets/TowerCraneAnimation.dae")
        simulationView.backgroundColor = UIColor.gray
        simulationView.present(scene, with: .fade(withDuration: 0.1), incomingPointOfView: nil, completionHandler: nil)
        
    }
    
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
            break
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController
        {
            let vc = segue.destination as? MainViewController
            vc?.bluetooth = bluetooth
        }
    }
    
}

