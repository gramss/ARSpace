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
    
    init(_ sceneview: ARSCNView,_ name : String,_ planenode: SCNNode){
        NSLog("Airplane created")
        //create Node here
        airplanescene = SCNScene(named: name)!
        
        let nodeArray = airplanescene.rootNode.childNodes

        for childNode in nodeArray {
            airplanenode.addChildNode(childNode as SCNNode)
        }
        __scaleTo(0.10)          //Shrink the model
        __setPosition(0, -0.1, -1)    //Place the Airplane 0.5 meters ahead of you
        sceneview.scene.rootNode.addChildNode(airplanenode)
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
}
