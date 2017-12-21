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
    
    //Spawn the Text between edges 1 and 3
    let edges = view.cage?.edges
    let cageHeight = view.cage?.cageHeight
    var position = SCNVector3()
    position.y = edges![1].y + cageHeight!/2
    //Mittelpunkt zwischen Edge 1 und Edge 0
    position.x = (edges![3].x - edges![1].x)/2 + edges![1].x
    position.z = (edges![3].z - edges![1].z)/2 + edges![1].z
    
    //Textnode initialization
    var textnode = SCNNode()
    textnode.position = position
    
    //Rotate the Text corresponding
    textnode.eulerAngles = SCNVector3(x:0, y:-.pi/2, z:0)
    textnode.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
    textnode.geometry = text
    node.addChildNode(textnode)
    /*---ALEX Work----
    node.position = SCNVector3(x:0, y:0.02, z:-0.1)
    node.eulerAngles = SCNVector3(x:0, y:-.pi/2, z:0)
    node.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
    node.geometry = text
 */
    

    
    NSLog("Collision detected")
    return true
}
