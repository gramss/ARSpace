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
    
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    //var asteroidscene : SCNScene
    var asteroidnode: SCNNode?
    var sceneView : ARSCNView
    
    
    func createAsteroid(){
        
        
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.5)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown
        box.firstMaterial = material
        
        asteroidnode = SCNNode(geometry: box)
        let cc = getCameraCoordinates(sceneView: sceneView)
        
        let cX = randomFloat(min: (cc?.x)!-0.1, max: (cc?.x)!+0.1)
        let cY = randomFloat(min: (cc?.y)!-0.1, max: (cc?.y)!+0.1)
        let cZ = randomFloat(min: (cc?.z)!-0.1, max: (cc?.z)!+0.1)
        asteroidnode!.position = SCNVector3(cX!, cY!, cZ!)
        
        sceneView.scene.rootNode.addChildNode(asteroidnode!)
        
    }
    
    func randomFloat(min: Float, max: Float) -> Float? {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates? {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }
    
    init(_ sceneViewInit: ARSCNView){
        NSLog("Asteroid created")
        sceneView = sceneViewInit
        //asteroidscene = SCNScene(named: name)!
        //        cubeNode.position = SCNVector3(0, 0, -0.2) // SceneKit/AR coordinates are in meters
        //        sceneView.scene.rootNode.addChildNode(cubeNode)
        //        sceneview.scene = airplanescene
        
        //        airplanenode = airplanescene.rootNode     //OLD
//        let nodeArray = asteroidscene.rootNode.childNodes
//
//        for childNode in nodeArray {
//            asteroidnode.addChildNode(childNode as SCNNode)
//        }
//
//        sceneView.scene.rootNode.addChildNode(asteroidnode)
        self.createAsteroid()
        }
    
    
}

