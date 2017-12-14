//
//  Asteroid.swift
//  ARSpace
//
//  Created by Alexander Apfel on 05.11.17.
//  Copyright © 2017 Florian Gramß. All rights reserved.
//

import ARKit
import SceneKit
import UIKit

class Asteroid{
    var asteroidnode: SCNNode?
    var sceneView : ARSCNView
//    var startPoint : SCNVector3
//    var endPoint : SCNVector3
//    var animationTime : Double
    var plannode : SCNNode
    let fadeOutTime : Double = 0.72
    
    func createAsteroid(startPoint : SCNVector3, endPoint : SCNVector3, animationTime : Double){
        
        
//        let box = SCNBox(width: 0.06, height: 0.06, length: 0.06, chamferRadius: 0.0)
        let box = SCNSphere(radius: 0.03)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.init(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
        box.firstMaterial = material
        
        asteroidnode = SCNNode(geometry: box)
        
        //Physics
        asteroidnode?.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: box))
        asteroidnode?.physicsBody?.categoryBitMask = CollisionCategoryAsteroid
        asteroidnode?.physicsBody?.collisionBitMask =  CollisionCategoryAirplane
        asteroidnode?.physicsBody?.contactTestBitMask = CollisionCategoryAirplane
        asteroidnode?.physicsBody?.isAffectedByGravity = false
        
        //Rotation doesnt work already
//        asteroidnode?.physicsBody?.angularDamping = 0   //If it wants to rotate, it will not go slower
//        asteroidnode?.physicsBody?.momentOfInertia = SCNVector3(0,1,0)
//        asteroidnode?.physicsBody?.usesDefaultMomentOfInertia = false
//        asteroidnode?.physicsBody?.applyTorque(SCNVector4(100,100,100,100), asImpulse: true)

        asteroidnode!.position = startPoint
        
        let moveShip    = SCNAction.move(to: endPoint, duration: animationTime)
        let fadeOut     = SCNAction.fadeOut(duration: fadeOutTime)
        let removeNode  = SCNAction.removeFromParentNode()
        let routine     = SCNAction.sequence([moveShip, fadeOut, removeNode])
        __myrunAction(routine)
        
        //sceneView.scene.rootNode.addChildNode(asteroidnode!)
        plannode.addChildNode(asteroidnode!)
    }
    
    func randomCGFloat() -> CGFloat {
        let min : CGFloat = 0
        let max : CGFloat = 1
        return (CGFloat(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    init(_ sceneViewInit: ARSCNView, _ planenode: SCNNode ){
        NSLog("Asteroid created")
        sceneView = sceneViewInit
        self.plannode = planenode
//        self.startPoint = startPoint
//        self.endPoint = endPoint
//        self.animationTime = animationTime
//
//        self.createAsteroid()
        }
    
    func __myrunAction(_ routine: SCNAction){
        asteroidnode?.runAction(routine)
    }
}

