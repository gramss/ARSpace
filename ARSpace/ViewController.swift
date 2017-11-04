//
//  ViewController.swift
//  ARFun
//
//  Created by Alexander Apfel on 04.11.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func btnLeft(_ sender: UIButton) {
    }
    @IBAction func btnRight(_ sender: UIButton) {
    }
    @IBAction func btnUp(_ sender: UIButton) {
    }
    @IBAction func btnDown(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        
        let airpl = Airplane(sceneView, "art.scnassets/ship.scn")
        airpl.moveRight()
        
//        for node in sceneView.scene.rootNode.childNodes {
//            let moveShip = SCNAction.moveBy(x: 0, y: 0.5, z: -0.5, duration: 1)
//            let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1)
//            let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 1)
//            let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
//            let foreverRoutine = SCNAction.repeatForever(routine)
            
            
//            node.runAction(foreverRoutine)
//            airpl.moveRight()
//            node.
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("added");
        if let plane = anchor as? ARPlaneAnchor {
            print("X: \(plane.extent.x)m Z: \(plane.extent.z)m");
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print("update");
        if let plane = anchor as? ARPlaneAnchor {
            print("X: \(plane.extent.x)m Z: \(plane.extent.z)m");
        }
    }
}
