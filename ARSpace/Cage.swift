//
//  Cage.swift
//  ARSpace
//
//  Created by Interaktion1718 on 16.11.17.
//  Copyright © 2017 Florian Gramß. All rights reserved.
//

import SceneKit

class Cage {
    var edges : [SCNVector3] = []           //Array for all 8 Edges
    var centerPos = SCNVector3()
    var width  : Float
    var length : Float
    
    init(_ planeNode : SCNNode, _ airplaneHeigth : Float,_ cageHeight : Float, _ node : SCNNode){
        centerPos = planeNode.position //Let's see if this works
        let centerX = centerPos.x
        let centerY = centerPos.z
//        let centerZ = centerPos.z
        NSLog("centerPos: %d %d %d", centerPos.x, centerPos.y, centerPos.z)
        
        var planeGeometry : SCNPlane
        planeGeometry = planeNode.geometry as! SCNPlane
        width = Float(planeGeometry.width)
        length = Float(planeGeometry.height)       //The plane is rotated by 90° so it's height is really it's length
        //CURRENTLY HERE!
        if(length > width || true){
//            edges[0] = SCNVector3(
            NSLog("Length > Width")
            edges.append(SCNVector3Make(centerX - width/2, airplaneHeigth, centerY - length/2))
            generateCube(vector: edges[0], color: UIColor.red, node: node)
            
            edges.append(SCNVector3Make(centerX + width/2, airplaneHeigth, centerY - length/2))
            generateCube(vector: edges[1], color: UIColor.blue, node: node)
            edges.append(SCNVector3Make(centerX - width/2, airplaneHeigth, centerY + length/2))
            generateCube(vector: edges[2], color: UIColor.green, node: node)
            edges.append(SCNVector3Make(centerX + width/2, airplaneHeigth, centerY + length/2))
            generateCube(vector: edges[3], color: UIColor.yellow, node: node)
            edges.append(SCNVector3Make(centerX - width/2, airplaneHeigth + cageHeight, centerY - length/2))
            generateCube(vector: edges[4], color: UIColor.black, node: node)
            edges.append(SCNVector3Make(centerX + width/2, airplaneHeigth + cageHeight, centerY - length/2))
            generateCube(vector: edges[5], color: UIColor.purple, node: node)
            edges.append(SCNVector3Make(centerX - width/2, airplaneHeigth + cageHeight, centerY + length/2))
            generateCube(vector: edges[6], color: UIColor.orange, node: node)
            edges.append(SCNVector3Make(centerX + width/2, airplaneHeigth + cageHeight, centerY + length/2))
            generateCube(vector: edges[7], color: UIColor.magenta, node: node)
            
            generateCube(vector: SCNVector3(centerX,centerY,airplaneHeigth), color: UIColor.brown, node: node)
            NSLog("Edges length: %d", edges.count)
        }
        else{
            
            NSLog("Width > Length")
        }
        
        
        
    }
    
    func isInside(position : SCNVector3) -> Bool {
        //Calculate here
        if true {
            return true
        }
        else{
            
            return false
        }
    }
    
    func generateCube(vector : SCNVector3, color : UIColor, node : SCNNode){
        //TEST
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = color
        cube.firstMaterial = material
        let testnode = SCNNode(geometry: cube)
        
        testnode.simdPosition = float3(vector.x, vector.y, vector.z)
        node.addChildNode(testnode)
    }
    
    
}
