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
    let animduration : Double = 0.25
    let movedistanceUpDown : CGFloat
    var movedistanceLeftRight : CGFloat
    let cage : Cage
    
    init(_ sceneview: ARSCNView,_ name : String,_ planenode: SCNNode,_ refCage: Cage){
        NSLog("Airplane created")
        cage = refCage
        //Let the Airplane move only 10% of the short Side per click
        movedistanceUpDown = CGFloat(cage.shorterDistance/Float(10))
        //The factor for moveddistance is manipulated in the rotateAirplane Function
        movedistanceLeftRight = movedistanceUpDown
        //create Node here
        airplanescene = SCNScene(named: name)!
        
        //Add All Nodes (for all parts of the airplane) to the airplane node
        let nodeArray = airplanescene.rootNode.childNodes
        for childNode in nodeArray {
            airplanenode.addChildNode(childNode as SCNNode)
            //Set the Childnodes directly on the airplanenode
            childNode.position = SCNVector3(0,0,0)
        }

        
//        sceneview.scene.rootNode.addChildNode(airplanenode)
        rotateAirplanetoGamefield()
        planenode.addChildNode(airplanenode)
        
        //Modify the Model
        __setPositionVector(newPos: cage.getSpawnPointAirplane())
        __scaleTo(Double(cage.shorterDistance/Float(5)))          //Shrink the model

        //Initialize the Airplane collision physics
        airplanenode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(node: airplanenode, options: nil))
        airplanenode.physicsBody?.categoryBitMask = CollisionCategoryAirplane
        airplanenode.physicsBody?.collisionBitMask = CollisionCategoryAsteroid
        airplanenode.physicsBody?.categoryBitMask = (airplanenode.physicsBody?.collisionBitMask)!
        airplanenode.physicsBody?.isAffectedByGravity = false
//        sceneview.scene.rootNode.addChildNode(airplanenode)
        //Rotate the Airplane to the Gamefield
  
//        __rotate(rotateVector: SCNVector3())
        //TESTS
        /////////
    }

    func moveLeft() -> Bool{
        NSLog("MOVE LEFT")
        var moveShip : SCNAction = SCNAction()
        var currPos = airplanenode.position
        var isNextTurnInside : Bool = true
        if cage.shorterDistance == cage.width {     //Length > Width
            //DECIDE IF YOU NEED TO SWITCH LEFT AND RIGHT HERE!!
//            NSLog("currPos.x before %f", currPos.x)
            currPos.x += Float(movedistanceLeftRight)
//            NSLog("currPos.x after %f", currPos.x)
            if cage.isInside(position: currPos){
                moveShip = SCNAction.moveBy(x: movedistanceLeftRight, y: 0, z: 0, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveRight-X)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x + Float(movedistanceLeftRight), currPos.y, currPos.z))){
                isNextTurnInside = false
            }
            
        }
        else    //Width > Length
        {
//            NSLog("CurrPos Z before %f", currPos.z)
            currPos.z += Float(movedistanceLeftRight)
//            NSLog("CurrPos Z after %f", currPos.z)
            if(cage.isInside(position: currPos)){
                moveShip = SCNAction.moveBy(x: 0, y: 0, z: movedistanceLeftRight, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveRight-Z)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x , currPos.y, currPos.z + Float(movedistanceLeftRight)))){
                isNextTurnInside = false
            }
        }
//        let moveShip = SCNAction.moveBy(x: movedistanceLeftRight, y: 0, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
        return isNextTurnInside
    }
    func moveRight() -> Bool{
        NSLog("MOVE RIGHT")
        var moveShip : SCNAction = SCNAction()
        var currPos = airplanenode.position
        var isNextTurnInside : Bool = true                        //Variable to show if a next move to the right is possible
        
        if cage.shorterDistance == cage.width {     //Length > Width
            //DECIDE IF YOU NEED TO SWITCH LEFT AND RIGHT HERE!!
//            NSLog("currPos.x before %f", currPos.x)
            currPos.x += Float(-movedistanceLeftRight)
//            NSLog("currPos.x after %f", currPos.x)
            if cage.isInside(position: currPos){
                moveShip = SCNAction.moveBy(x: -movedistanceLeftRight, y: 0, z: 0, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveRight-X)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x + Float(-movedistanceLeftRight), currPos.y, currPos.z))){
                isNextTurnInside = false
            }
            
        }
        else    //Width > Length
        {
//            NSLog("CurrPos Z before %f", currPos.z)
            currPos.z += Float(-movedistanceLeftRight)
//            NSLog("CurrPos Z after %f", currPos.z)
            if(cage.isInside(position: currPos)){
                moveShip = SCNAction.moveBy(x: 0, y: 0, z: -movedistanceLeftRight, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveRight-Z)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x , currPos.y, currPos.z + Float(-movedistanceLeftRight)))){
                isNextTurnInside = false
            }
        }
        //        let moveShip = SCNAction.moveBy(x: -movedistanceLeftRight, y: 0, z: 0, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
        
        return isNextTurnInside
    }
    func moveUp() -> Bool{
        NSLog("MOVE UP")
        
        var isNextTurnInside : Bool = true
        
        var moveShip : SCNAction  = SCNAction()
        
        
        if g_curr_Game_State == 1 {
            moveShip =  SCNAction.moveBy(x: 0, y: movedistanceUpDown, z: 0, duration: animduration)
            cage.moveCageUpDown(distance: Float(movedistanceUpDown))
        }
        else if (g_curr_Game_State == 2){       //Game started
            var currPos = airplanenode.position
            currPos.y += Float(movedistanceUpDown)
            
            if cage.isInside(position: currPos){
                moveShip =  SCNAction.moveBy(x: 0, y: movedistanceUpDown, z: 0, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveUP)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x, currPos.y + Float(movedistanceUpDown), currPos.z))){
                isNextTurnInside = false
            }
        }
        
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
        
        return isNextTurnInside
        
    }
    func moveDown() -> Bool{
        NSLog("MOVE DOWN")
        
        var isNextTurnInside : Bool = true
        var moveShip : SCNAction  = SCNAction()
        
        if g_curr_Game_State == 1 {
            moveShip = SCNAction.moveBy(x: 0, y: -movedistanceUpDown, z: 0, duration: animduration)
            cage.moveCageUpDown(distance: Float(-movedistanceUpDown))
        }
        else if (g_curr_Game_State == 2){       //Game started
            var currPos = airplanenode.position
            currPos.y += Float(-movedistanceUpDown)
            
            if cage.isInside(position: currPos){
                moveShip =  SCNAction.moveBy(x: 0, y: (-movedistanceUpDown), z: 0, duration: animduration)
            }
            else{
                NSLog("Airplane tried to move out of cage!(moveDown)")
            }
            if(!cage.isInside(position: SCNVector3(currPos.x, currPos.y + Float(-movedistanceUpDown), currPos.z))){
                isNextTurnInside = false
            }
        }
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
        return isNextTurnInside
    }
    /*----------------OLD FUNCTIONS-------------------*
    func moveForward(){
        NSLog("MOVE FORWARD")
        
        let moveShip = SCNAction.moveBy(x: 0, y: 0, z: -movedistanceUpDown , duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
    func moveBackward(){
        NSLog("MOVE BACKWARD")
        
        let moveShip = SCNAction.moveBy(x: 0, y: 0, z: movedistanceUpDown, duration: animduration)
        let routine = SCNAction.sequence([moveShip])
        __myrunAction(routine)
    }
 /*--------------------------------------------------- */ */
    func __myrunAction(_ routine: SCNAction){
//        let nodeArray = airplanenode.childNodes
//
//        for childNode in nodeArray {
//            childNode.runAction(routine)
//        }
        airplanenode.runAction(routine)
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
        airplanenode.position = newPos
    }
    func __rotate(rotateDegree : Int) {
//        let nodeArray = airplanenode.childNodes
//        for childNode in nodeArray {
//            childNode.eulerAngles.y = .pi/2
//        }
        airplanenode.eulerAngles.y = (.pi * Float(rotateDegree)/Float(180))
    }
    func rotateAirplanetoGamefield() {
        //Airplane always spawns in positive z Direction
        var rotateDegree : Int = 0
        if (cage.shorterDistance == cage.width) {       //Length > Width
            //Now maybe rotate by 180 degree
            if(cage.edges[2].z - cage.edges[0].z < 0){
                //Gamefield is in negative Z direction -> Rotate the airplane by 180 degree
                NSLog("Rotate the airplane by 180 Degree")
                rotateDegree = 180
            }
        }
        else{                                           //Width > Length
            //Rotate by 90 or -90 degree
            //edges[0] is always the right end of the gamefield, edges [1] the left one
            if(cage.edges[1].z - cage.edges[0].z < 0){
                NSLog("Rotate Airplane by 90")
                rotateDegree = 90
                //Invert the Control for left right
                movedistanceLeftRight = -movedistanceLeftRight
            }
            else{
                NSLog("Rotate Airplane by 270(-90)")
                rotateDegree = 270
            }
        }
        __rotate(rotateDegree: rotateDegree)
    }
}
