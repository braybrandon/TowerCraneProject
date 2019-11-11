//
//  Simulator.swift
//  Tower_Crane_Bluetooth_APP
//
//  Created by Brandon Bray on 11/10/19.
//  Copyright © 2019 Brandon Bray. All rights reserved.
//

import SceneKit
import CoreBluetooth

class Simulator: UIViewController, CBPeripheralDelegate, SCNSceneRendererDelegate {
    
    var scene: SCNScene!
    var externalview: UIView!
    var sceneView: SCNView!
    var towerNode = SCNNode()
    var cameraNode = SCNNode()
    var rotateAnimation: CAAnimation!
    
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral!
    var writeCharacteristics: CBCharacteristic!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        connectedPeripheral.delegate = self
        super.viewDidLoad()
        sceneView = SCNView()
        sceneView.delegate = self
        externalview = UIView()
        externalview = self.view
        self.view!.backgroundColor = UIColor.gray
        scene = SCNScene(named: "art.scnassets/TowerCraneAnimation.dae")
        sceneView.scene = scene
        self.view = sceneView
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteric: CBCharacteristic, error: Error?) {
          let data = characteric.value
        let str = String(decoding: data!, as: UTF8.self)
        print(str)
            self.view = externalview
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

