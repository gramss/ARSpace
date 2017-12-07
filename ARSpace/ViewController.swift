//
//  ViewController.swift
//  ARFun
//
//  Created by Alexander Apfel on 04.11.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

//Defines
let CollisionCategoryAirplane    = 1 << 0
let CollisionCategoryAsteroid    = 1 << 1

var g_curr_Game_State = 0

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var planeNode : SCNNode = SCNNode()
    var airpl : Airplane?
    var asteroid : Asteroid?
    var asteroidsSpawnTimer : Timer?
    var asteroidSpawnFieldVar : Int = 0
    var cage : Cage?
    var scanFinished = false
    
    
    
    @IBOutlet weak var startView: UIView!
    
    @IBOutlet weak var btnCntrlRight: UIButton!
    @IBOutlet weak var btnCntrlLeft: UIButton!
    @IBAction func btnCntrlForwardPressed(_ sender: Any) {
        airpl?.moveForward()
    }
    @IBAction func btnCntrlBackwardPressed(_ sender: Any) {
        airpl?.moveBackward()
    }
    
    @IBOutlet weak var controlView: UIView!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var lblTextForStart: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBAction func btnStart(_ sender: UIButton) {

        //sceneView.showsStatistics = false // turn of point cloud when pane is found
        // turn on visible pane?
        if !scanFinished{
            g_curr_Game_State = 1;
            lblTextForStart.text = ""
            scanFinished = true
            //Place Airplane
            
            cage = Cage(planeNode, 0.01, 0.5, planeNode.parent!)
            asteroid = Asteroid(sceneView, planeNode.parent!)
            airpl = Airplane(sceneView, "art.scnassets/ship.scn", planeNode.parent!, cage!)
            airpl?.__setPositionVector(newPos: cage!.getSpawnPointAirplane())
            
            //activate the two arrows
            btnCntrlRight.isHidden = true
            btnCntrlLeft.isHidden  = true
            controlView.isHidden = false
            
            
        }else{
            g_curr_Game_State = 2;
            startView.isHidden = true
            btnCntrlLeft.isHidden  = false
            btnCntrlRight.isHidden = false
            self.startSpawningAsteroids(spawnInterval: 1)
        }
    }
    func planeFound() {
        DispatchQueue.main.async { // Correct
            self.btnStart.isHidden = false
            self.lblTextForStart.text = "Press the butten to play"
        }

    }
    
    func notLookingAtPane() {
        btnStart.setImage(#imageLiteral(resourceName: "icons8-start_filled-greyished"), for: UIControlState .normal)
    }
    func lookingAtPane(){
        btnStart.setImage(#imageLiteral(resourceName: "icons8-start_filled"), for: UIControlState .normal)
    }
    
    @IBAction func btnLeft(_ sender: UIButton) {
        airpl?.moveLeft()
    }
    @IBAction func btnRight(_ sender: UIButton) {
        airpl?.moveRight()
    }
    @IBAction func btnUp(_ sender: UIButton) {
        airpl?.moveUp()
    }
    @IBAction func btnDown(_ sender: UIButton) {
        airpl?.moveDown()
    }
    
    @IBOutlet weak var outletFeaturePoints: UISwitch!
    @IBAction func btnFeaturePoints(_ sender: UISwitch) {
        if(outletFeaturePoints.isOn)
        {
            sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        }
        if(!outletFeaturePoints.isOn)
        {
            sceneView.debugOptions = []
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //controlView.isHidden = true
        // Set the view's delegate
        sceneView.delegate = self
        
        //Featurepoints anzeigen
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        
//        airpl = Airplane(sceneView, "starship.dae", sceneView)
//        airpl.moveRight()
//
//        for node in sceneView.scene.rootNode.childNodes {
//            let moveShip = SCNAction.moveBy(x: 0, y: 0.5, z: -0.5, duration: 1)
//            let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1)
//            let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 1)
//            let routine = SCNAction.sequence([fadeOut, fadeIn, moveShip])
//            let foreverRoutine = SCNAction.repeatForever(routine)
//
//
//            node.runAction(foreverRoutine)
//
//            airpl.moveRight()
//            node.
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("added");
        if(renderer_Add(node: node, anchor: anchor, sceneView: sceneView, planeNode: &planeNode, viewcontroller: self)){
            
        }
        //In RendererFunctions
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        print("update");
        renderer_Update(planeNode: &planeNode, anchor: anchor)
    }
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact){
        physicsWorldCollisionDetected(world, didBegin: contact)
    }
    
    func startSpawningAsteroids(spawnInterval : Double){
        asteroidsSpawnTimer?.invalidate()
        // start the timer
        asteroidsSpawnTimer = Timer.scheduledTimer(timeInterval: spawnInterval , target: self, selector: #selector(spawnAsteroid), userInfo: nil, repeats: true)
    }
    
    func stopSpawningAsteroids(){
        asteroidsSpawnTimer?.invalidate()
    }
    @objc func spawnAsteroid(){
        let speed : Double = 10
        asteroidSpawnFieldVar += 1
        if asteroidSpawnFieldVar > 4 {
            asteroidSpawnFieldVar = 0
        }
        let PointVect = cage!.getSpawnPointAsteroid(spawnField: asteroidSpawnFieldVar)
        asteroid!.createAsteroid(startPoint: PointVect[0], endPoint: PointVect[1], animationTime: speed)
    }
}

//Errorhandling - Fehlerausgabe bei fehlendem Camera access oder bei Interrupt und Ende
extension ViewController: ARSKViewDelegate {
    func session(_ session: ARSession,
                 didFailWithError error: Error) {
        print("Session Failed - probably due to lack of camera access")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("Session interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session resumed")
        sceneView.session.run(session.configuration!,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }
}
