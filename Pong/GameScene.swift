//
//  GameScene.swift
//  Pong
//
//  Created by SUP'Internet 09 on 08/03/2018.
//  Copyright © 2018 GM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    
    var elements = [String: SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        elements["ball"] = self.childNode(withName: "ball") as! SKSpriteNode
        
        elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        frameBody.friction = 0
        frameBody.restitution = 1
        
        self.physicsBody = frameBody
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
}
