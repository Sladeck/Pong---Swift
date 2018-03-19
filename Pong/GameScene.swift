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
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func didMove(to view: SKView) {
        
        let numberOfSprites = 20 // number of sprite
        
        for i in 0..<numberOfSprites {
            let index = SKSpriteNode(color: randomColor(), size: CGSize(width: 100, height: 50))
            
            let pb = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 50))
            
            index.physicsBody = pb
            index.physicsBody?.affectedByGravity = false
            
            index.position = CGPoint(x: -200 + i, y: 500)
            
            addChild(index)
        }
        
        elements["brick_1"] = self.childNode(withName: "brick_1") as? SKSpriteNode
        
        elements["player_bottom"] = self.childNode(withName: "player_bottom") as? SKSpriteNode
        
        elements["ball"] = self.childNode(withName: "ball") as? SKSpriteNode
        
        elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        frameBody.friction = 0
        frameBody.restitution = 1
        
        self.physicsBody = frameBody
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if(location.y < 0) {
            elements["player_bottom"]?.run( SKAction.moveTo(x: location.x, duration: 0.3))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if(location.y < 0) {
                elements["player_bottom"]?.run( SKAction.moveTo(x: location.x, duration: 0.3))
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //self.childNode(withName: "brick_1")?.removeFromParent()
        
        let locationY = elements["ball"]?.position.y
        
        if(locationY! < CGFloat(-600)) {
            elements["ball"]?.position = CGPoint(x: 0, y: 0)
        }

    }
    
    let shockWaveAction: SKAction = {
        let growAndFadeAction = SKAction.group([SKAction.scale(to: 50, duration: 0.5),
                                                SKAction.fadeOut(withDuration: 0.5)])
        
        let sequence = SKAction.sequence([growAndFadeAction,
                                          SKAction.removeFromParent()])
        
        return sequence
    }()
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "brick_1" {
            
            let shockwave = SKShapeNode(circleOfRadius: 1)
            
            shockwave.position = contact.contactPoint
            scene?.addChild(shockwave)
            
            shockwave.run(shockWaveAction)
            
        }
        
    }
}
