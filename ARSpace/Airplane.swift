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
    let cage : Cage
    
    init(_ sceneview: ARSCNView,_ name : String,_ planenode: SCNNode,_ refCage: Cage){
        NSLog("Airplane created")
        cage = refCage
        //create Node here
        airplanescene = SCNScene(named: name)!
        
        let nodeArray = airplanescene.rootNode.childNodes

        for childNode in nodeArray {
            airplanenode.addChildNode(childNode as SCNNode)
        }
        __scaleTo(0.10)          //Shrink the model
//        sceneview.scene.rootNode.addChildNode(airplanenode)
        __rotate(rotateVector: SCNVector3())
        planenode.addChildNode(airplanenode)
    }
    let animduration : Double = 0.25
    let movedistance : CGFloat = 0.5
    func moveLeft(){
        NSLog("MOVE LEFT")
        let moveShip = SCNAction.moveBy(x: -movedistance, y: 0, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveRight(){
        NSLog("MOVE RIGHT")
        
        let moveShip = SCNAction.moveBy(x: movedistance, y: 0, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveUp(){
        NSLog("MOVE UP")
        
        let moveShip = SCNAction.moveBy(x: 0, y: movedistance, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveDown(){
        NSLog("MOVE DOWN")
        
        let moveShip = SCNAction.moveBy(x: 0, y: -movedistance, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveForward(){
        NSLog("MOVE FORWARD")
        
        let moveShip = SCNAction.moveBy(x: 0, y: 0, z: -movedistance , duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveBackward(){
        NSLog("MOVE BACKWARD")
        
        let moveShip = SCNAction.moveBy(x: 0, y: 0, z: movedistance, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func __myrunAction(_ routine: SCNAction){
        let nodeArray = airplanenode.childNodes
        
        for childNode in nodeArray {
            childNode.runAction(routine)
        }
    }
    func __scaleTo(_ scaleFactor : Double){
        let nodeArray = airplanenode.childNodes
        
        for childNode in nodeArray {
            childNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        }
    }
    func __setPosition(_ x : Float,_ y : Float,_ z :Float){
        let nodeArray = airplanenode.childNodes
        
        for childNode in nodeArray {
            childNode.position = SCNVector3(x, y, z)
        }
    }
    func __setPositionVector(newPos : SCNVector3) {
        let nodeArray = airplanenode.childNodes
        for childNode in nodeArray {
            childNode.position = newPos
        }
    }
    func __rotate(rotateVector : SCNVector3) {
        let nodeArray = airplanenode.childNodes
        for childNode in nodeArray {
            childNode.eulerAngles.y = -.pi/2
        }
    }
}
