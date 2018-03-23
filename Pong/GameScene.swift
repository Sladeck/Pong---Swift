//
//  GameScene.swift
//  Pong
//
//  Created by SUP'Internet 09 on 08/03/2018.
//  Copyright © 2018 GM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    
    var elements = [String: SKSpriteNode]()
    
    let saviorCategory: UInt32 = 0x1 << 0
    let chickenCategory: UInt32 = 0x1 << 1
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        let numberOfSprites = 20 // number of sprite
        var X = -220
        var Y = 500
        
        for i in 0..<numberOfSprites {
            let index = SKSpriteNode(color: randomColor(), size: CGSize(width: 100, height: 50))
            
            let pb = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 50))
            
            index.physicsBody = pb
            index.physicsBody?.affectedByGravity = false
            index.physicsBody?.friction = 0
            index.physicsBody?.restitution = 1
            index.physicsBody?.pinned = true
            index.physicsBody?.allowsRotation = false
            index.physicsBody?.usesPreciseCollisionDetection = true
            index.physicsBody?.linearDamping = 0
            index.physicsBody?.angularDamping = 0
            
            index.physicsBody?.categoryBitMask = chickenCategory
            index.physicsBody?.contactTestBitMask = saviorCategory
            index.physicsBody?.collisionBitMask = saviorCategory
            
                if i == 3 || i == 7 || i == 11 || i == 15{
                    index.position = CGPoint(x: X, y: Y)
                    Y += -70
                    X = -220
                } else {
                    index.position = CGPoint(x: X, y: Y)
                    X += 140
                }
            
            
            
            addChild(index)
        }
        
        elements["brick_1"] = self.childNode(withName: "brick_1") as? SKSpriteNode
        
        elements["player_bottom"] = self.childNode(withName: "player_bottom") as? SKSpriteNode
        elements["player_bottom"]?.physicsBody?.categoryBitMask = chickenCategory
        elements["player_bottom"]?.physicsBody?.contactTestBitMask = saviorCategory
        elements["player_bottom"]?.physicsBody?.collisionBitMask = saviorCategory
        
        elements["ball"] = self.childNode(withName: "ball") as? SKSpriteNode
        elements["ball"]?.physicsBody?.categoryBitMask = saviorCategory
        elements["ball"]?.physicsBody?.contactTestBitMask = chickenCategory
        elements["ball"]?.physicsBody?.collisionBitMask = chickenCategory

        
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
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {

        if contact.bodyA.categoryBitMask == chickenCategory && contact.bodyB.categoryBitMask == saviorCategory {
            print("contact made")
            //savior.hidden = true
        }
        else if contact.bodyA.categoryBitMask == saviorCategory && contact.bodyB.categoryBitMask == chickenCategory {
            print("contact made")
            //savior.hidden = true
        }
    }
    
}
