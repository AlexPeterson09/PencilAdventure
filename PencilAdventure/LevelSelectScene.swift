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
}