//
//  GameScene.swift
//  PencilAdventure
//
//  Created by Alex Peterson on 10/6/14.
//  Copyright (c) 2014 Alex Peterson. All rights reserved.
//
//test
//test 2
import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    // character
    var steve:SKSpriteNode!
    var tv:SKSpriteNode!
    
    let heroCategory: UInt32 = 1 << 0
    let groundCategory: UInt32 = 1 << 1
    let levelCategory: UInt32 = 1 << 2
    let powerupCategory: UInt32 = 1 << 3
    let finishCategory: UInt32 = 1 << 5 //add finish category
    
    override func didMoveToView(view: SKView) {
        
        // setup physics
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 )
        self.physicsWorld.contactDelegate = self
        
        tv = SKSpriteNode(imageNamed: "tv")
        tv.name = "TV"
        tv.position = CGPoint(x:frame.size.width/4, y:frame.size.height/2)
        self.addChild(tv)
        
        //add steve
        steve = SKSpriteNode(imageNamed: "steve") //#1
        steve.name = "Steve"
        steve.physicsBody = SKPhysicsBody(rectangleOfSize: steve.size) //#2
        steve.physicsBody?.dynamic = true //#3
        steve.physicsBody?.allowsRotation = false //#4
        steve.physicsBody?.mass = 0.6 //#5
        
        steve.physicsBody?.categoryBitMask = heroCategory //#1
        steve.physicsBody?.collisionBitMask = levelCategory | powerupCategory | groundCategory | finishCategory //#2
        steve.physicsBody?.contactTestBitMask = levelCategory | powerupCategory | groundCategory | finishCategory //#3
        
        steve.position = CGPoint(x:frame.size.width/4, y:frame.size.height/2)
        steve.zPosition = 1
        self.addChild(steve)
        
        let background = SKTexture(imageNamed: "paper")
        // Make it cheap to draw
        background.filteringMode = SKTextureFilteringMode.Nearest
        
        let bgSprite = SKSpriteNode(texture: background)
        bgSprite.size = frame.size
        bgSprite.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
        bgSprite.zPosition = -10
        addChild(bgSprite)
        
        //add platform
        let platform = SKSpriteNode(imageNamed: "wall") 					//#1
        platform.name = "Wall"
        platform.physicsBody = SKPhysicsBody(rectangleOfSize: platform.size)//#2
        platform.physicsBody?.dynamic = false								//#2
        platform.physicsBody?.allowsRotation = false						//#2
        platform.physicsBody?.categoryBitMask = levelCategory  //#1
        platform.physicsBody?.collisionBitMask = heroCategory //#1
        platform.position = CGPoint(x:380.0, y:(platform.size.height/2))
        platform.zPosition = 0
        addChild(platform)
        
        //add sharpener
        let sharpener = SKSpriteNode(imageNamed: "sharpener")				//#3
        sharpener.name = "Sharpener"
        sharpener.setScale(0.33)
        sharpener.physicsBody = SKPhysicsBody(circleOfRadius: sharpener.size.width/2)//#4
        sharpener.physicsBody?.dynamic = false										//#4
        sharpener.physicsBody?.allowsRotation = false								//#4
        sharpener.physicsBody?.categoryBitMask = powerupCategory //#2
        sharpener.physicsBody?.collisionBitMask = heroCategory //#2
        sharpener.position = CGPoint(x: 380, y: platform.size.height+(sharpener.size.height/2))
        sharpener.zPosition = 0
        addChild(sharpener)
        
        //add finish line
        let finish = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 5.0, height: frame.height)) //#1
        finish.name = "finish"
        finish.physicsBody = SKPhysicsBody(rectangleOfSize: finish.size)
        finish.physicsBody?.dynamic = false
        finish.physicsBody?.allowsRotation = false
        finish.physicsBody?.categoryBitMask = finishCategory    //#2
        finish.physicsBody?.collisionBitMask = heroCategory     //#3
        finish.position = CGPoint(x:480.0, y:frame.height*0.5)
        finish.zPosition = 0
        addChild(finish)
        
        //scrolling
        movingSprites()
        
        let ground = SKSpriteNode(color: UIColor(white: 1.0, alpha: 0), size:CGSize(width: frame.size.width, height: 5))
        // The ground is at the bottom of our viewable area
        ground.position = CGPoint(x: self.frame.size.width/2, y: self.frame.origin.y)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory //#3
        ground.physicsBody?.collisionBitMask = heroCategory //#3
        self.addChild(ground)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //#1
        if (contact.bodyA.categoryBitMask & powerupCategory) == powerupCategory || (contact.bodyB.categoryBitMask & powerupCategory) == powerupCategory {
            NSLog("get extra life")
        }
        //#2
        if (contact.bodyA.categoryBitMask & groundCategory) == groundCategory || (contact.bodyB.categoryBitMask & groundCategory) == groundCategory {
            NSLog("Oh No! Game over")
        }
        //#3
        if (contact.bodyA.categoryBitMask & levelCategory) == levelCategory || (contact.bodyB.categoryBitMask & levelCategory) == levelCategory {
            NSLog("Steve can Jump")
        }
        if (contact.bodyA.categoryBitMask & groundCategory) == groundCategory ||
            (contact.bodyB.categoryBitMask & groundCategory) == groundCategory {
                gameEnd(false)             //#1
        }
        //#2
        if (contact.bodyA.categoryBitMask & finishCategory) == finishCategory || (contact.bodyB.categoryBitMask & finishCategory) == finishCategory {
                gameEnd(true) 				//#3
        }
    }
    
    func gameEnd(didWin:Bool) {
        if didWin {
            NSLog("Yeah! You won!")     //#1
        } else {
            NSLog("Oh No! Game Over!")  //#2
        }
    }
    
    func movingPlatformFromLevel(sprite: SKSpriteNode) {
        //#3
        let distanceToMove = CGFloat(self.frame.size.width + sprite.size.width)
        //#3
        let movePlatform = SKAction.moveByX(-distanceToMove,y:0.0,duration:NSTimeInterval(0.01 * distanceToMove))
        let removePlatform = SKAction.removeFromParent() //#4
        let movePlatformAndRemove = SKAction.sequence([movePlatform, removePlatform]) //#5
        sprite.runAction(movePlatformAndRemove)
    }
    
    private func movingSprites() {
        // #7
        for child in self.children as [SKNode] {
            if let sprite = child as? SKSpriteNode {  //#8
                if sprite.zPosition == 0 {        //#9
                    movingPlatformFromLevel(sprite)
                }
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // touch to jump
        for touch: AnyObject in touches { //#1
            steve.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
        }
    }
}