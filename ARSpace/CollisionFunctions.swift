//
//  CollisionFunctions.swift
//  ARSpace
//
//  Created by Matze on 07.12.17.
//  Copyright © 2017 Florian Gramß. All rights reserved.
//

import Foundation
import SceneKit

func physicsWorldCollisionDetected(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact, view: ViewController, node: SCNNode, highscore: Int) -> Bool{
    view.stopSpawningAsteroids()
    
    //Gameend text
    let text = SCNText(string: "You Lost!\nHighscore \(highscore)", extrusionDepth: 1)
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.red
    text.materials = [material]
    
    node.position = SCNVector3(x:0, y:0.02, z:-0.1)
    node.eulerAngles = SCNVector3(x:0, y:-.pi/2, z:0)
    node.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
    node.geometry = text
    

    
    NSLog("Collision detected")
    return true
}
