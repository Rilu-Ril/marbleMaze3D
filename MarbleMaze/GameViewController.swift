//
//  GameViewController.swift
//  MarbleMaze
//
//  Created by Sanira on 11/21/16.
//  Copyright © 2016 Ril. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    let CollisionCategoryBall = 1
    let CollisionCategoryStone = 2
    let CollisionCategoryPillar = 4
    let CollisionCategoryCrate = 8
    let CollisionCategoryPearl = 16
    var ballNode:SCNNode!
    var scnView: SCNView!
    var scnScene: SCNScene!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnScene = SCNScene(named: "art.scnassets/game.scn")
        scnView.scene = scnScene
        scnScene.physicsWorld.contactDelegate = self
    }
    func setupNodes() {
        ballNode = scnScene.rootNode.childNode(withName: "ball",
                                               recursively: true)!
        ballNode.physicsBody?.contactTestBitMask = CollisionCategoryPillar |
            CollisionCategoryCrate | CollisionCategoryPearl
        
    }
    func setupSounds() {
    }
    
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }
}

extension   GameViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
       
        var contactNode:SCNNode!
        if contact.nodeA.name == "ball" {
            contactNode = contact.nodeB
        } else {
            contactNode = contact.nodeA
        }
        if contactNode.physicsBody?.categoryBitMask == CollisionCategoryPearl
        {
            contactNode.isHidden = true
            contactNode.runAction(SCNAction.waitForDurationThenRunBlock(duration: 30)
            { (node:SCNNode!) -> Void in
                node.isHidden = false
            })
        }
        
        if contactNode.physicsBody?.categoryBitMask ==
            CollisionCategoryPillar || contactNode.physicsBody?.categoryBitMask ==
            CollisionCategoryCrate {
        }
    }
}
