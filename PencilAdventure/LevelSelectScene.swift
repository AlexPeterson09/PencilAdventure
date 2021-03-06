//
//  LevelSelectScene.swift
//  PencilAdventure
//
//  Created by Alex Peterson on 11/7/14.
//  Copyright (c) 2014 Alex Peterson. All rights reserved.
//

import Foundation
import SpriteKit

class LevelSelectScene : SKScene {
    
    // Constants
    let MaxLevels = 4

    // Variables
    var progressLoader: ProgressLoaderNode!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)

        // Setup background music.
        SoundManager.toggleBackgroundMusic()

        // Add a background.
        let backgroundTexture = SKSpriteNode(color: UIColor(red: 154/255, green: 208/255, blue: 217/255, alpha: 1.0), size: frame.size)
        backgroundTexture.position = CGPointMake(frame.width / 2, frame.height / 2)
        addChild(backgroundTexture)

        // Add a title.
        let levelLabel = SKLabelNode(text: “Please choose a level")
            levelLabel.fontColor = SKColor.darkGrayColor()
            levelLabel.fontName = "Noteworthy"
            levelLabel.position = CGPoint(x: view.frame.width / 2, y: (view.frame.height / 2) + 50)
            levelLabel.xScale = getSceneScaleX()
            levelLabel.yScale = getSceneScaleY()
            addChild(levelLabel)

            // Add level select and high score nodes.
            addLevelSelectAndHighScoreNodes()
    }
    internal func addLevelSelectAndHighScoreNodes () {
        // Load our our required resources.
        let atlas = SKTextureAtlas(named: "Levels")
        let levelTile = atlas.textureNamed("L1-enabled")
        
        // In order to create a grid for the level buttons,
        // we a tile width, height and a value for the gap
        // in between them.
        var tileWidth = levelTile.size().width
        var tileHeight = levelTile.size().height
        var gap = tileWidth
        
        // We also need a selector width and an initial x
        // and y coordinate set.
        var selectorWidth = tileWidth * CGFloat(MaxLevels) + gap * CGFloat(MaxLevels - 2)
        var x = (view.frame.width - selectorWidth) / 2
        var y = view.frame.height / 2
        
        // For every level, add a level selector.
        for i in 1...MaxLevels {
            // The first two levels we statically enable,
            // while we leave the last two disabled.
            var suffix = "disabled"
            if i == 1 || i == 2 {
                suffix = "enabled"
            }
            
            // Create a level selector node and add it to
            // the scene.
            let level = SKSpriteNode(texture: atlas.textureNamed("L\(i)-\(suffix)"))
            level.name = "\(i)"
            level.position = CGPoint(x: x, y: y)
            level.xScale = getSceneScaleX()
            level.yScale = getSceneScaleY()
            addChild(level)
            
            // Move the x value over, as to not render two
            // nodes on top of each other.
            x += tileWidth + gap
            }
        
        // If high scores are available, display them
        // as a label node.
        if let highestScores = ScoreManager.getAllHighScores() {
            let highScoreLabel = SKLabelNode(text: "High Score\n\(highestScores)")
            highScoreLabel.fontColor = SKColor.darkGrayColor()
            highScoreLabel.fontName = "Noteworthy"
            highScoreLabel.fontSize = 14
            highScoreLabel.position[…]
        }
    }
}
