//
//  Airplane.swift
//  ARFun
//
//  Created by Matthias Vietz on 04.11.17.
//  Copyright © 2017 Alex. All rights reserved.
//
import ARKit
import SceneKit

class Airplane{
    var airplanescene : SCNScene
    let airplanenode = SCNNode()        //Array of all nodes
    
    init(_ sceneview: ARSCNView,_ name : String){
        NSLog("Airplane created")
        //create Node here
        airplanescene = SCNScene(named: name)!
//        cubeNode.position = SCNVector3(0, 0, -0.2) // SceneKit/AR coordinates are in meters
//        sceneView.scene.rootNode.addChildNode(cubeNode)
//        sceneview.scene = airplanescene
        
//        airplanenode = airplanescene.rootNode     //OLD
        let nodeArray = airplanescene.rootNode.childNodes

        for childNode in nodeArray {
            airplanenode.addChildNode(childNode as SCNNode)
        }
        sceneview.scene.rootNode.addChildNode(airplanenode)
    }
    let animduration : Double = 1
    let movedistance : CGFloat = 3
    func moveLeft(){
        let moveShip = SCNAction.moveBy(x: -movedistance, y: 0, z: 0, duration: animduration)
        let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: animduration)
        let fadeIn = SCNAction.fadeOpacity(to: 1, duration: animduration)
        let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
        __myrunAction(routine)
    }
    func moveRight(){
        
        let moveShip = SCNAction.moveBy(x: movedistance, y: 0, z: 0, duration: animduration)
        let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: animduration)
        let fadeIn = SCNAction.fadeOpacity(to: 1, duration: animduration)
        let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
        __myrunAction(routine)
    }
    func moveUp(){
        let moveShip = SCNAction.moveBy(x: 0, y: movedistance, z: 0, duration: animduration)
        let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: animduration)
        let fadeIn = SCNAction.fadeOpacity(to: 1, duration: animduration)
        let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
        __myrunAction(routine)
    }
    func moveDown(){
        let moveShip = SCNAction.moveBy(x: 0, y: -movedistance, z: 0, duration: animduration)
        let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: animduration)
        let fadeIn = SCNAction.fadeOpacity(to: 1, duration: animduration)
        let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
        __myrunAction(routine)
    }
    func __myrunAction(_ routine: SCNAction){
        let nodeArray = airplanenode.childNodes
        
        for childNode in nodeArray {
            childNode.runAction(routine)
        }
    }
}
