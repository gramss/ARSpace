//
//  CollisionFunctions.swift
//  ARSpace
//
//  Created by Matze on 07.12.17.
//  Copyright © 2017 Florian Gramß. All rights reserved.
//

import Foundation
import SceneKit
func physicsWorldCollisionDetected(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact, view: ViewController) -> Bool{
    view.stopSpawningAsteroids()
    NSLog("Collision detected")
    return true
}
