//
//  Cage.swift
//  ARSpace
//
//  Created by Interaktion1718 on 16.11.17.
//  Copyright © 2017 Florian Gramß. All rights reserved.
//

import SceneKit

class Cage {
    var anchorNode = SCNVector3(0,0,0)
    var edges : [SCNVector3] = []           //Array for all 8 Edges
    
    init(_ planeNode : SCNVector3, _ airplaneHeigth : SCNVector3, _ length : CGFloat, _ width : CGFloat, _ height : CGFloat) {
        anchorNode = planeNode
        
        
        
        
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
    
    
}
