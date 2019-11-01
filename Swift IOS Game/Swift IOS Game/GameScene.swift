//
//  GameScene.swift
//  Swift IOS Game
//
//  Created by Ryan Wilkinson on 26/09/19.
//  Copyright © 2019 Ryan Wilkinson. All rights reserved.
//


/*
 Note All the Slides Have Been Added Following Up To:
 Slide 9 Which Still Needs To be Added
 Along with that the last notes in week 8s could prove useful
*/

import UIKit
import SpriteKit
//import GameplayKit

class MainMenu: SKScene
{
    let left = SKSpriteNode()
    let right = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        self.backgroundColor = UIColor.gray
        left.color = UIColor.red
        left.size = CGSize(width: 64, height: 64)
        left.position = CGPoint(x: self.frame.width/2 + 64, y: self.frame.height/2)
        addChild(right)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first?.location(in: self)
        if left.contains(location!)
        {
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .down, duration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesIncomingScene = false
        }
        else if right.contains(location!)
        {
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.crossFade(withDuration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesIncomingScene = true
        }
        
    }
}




class GameScene: SKScene
{
    
    private let node = SKSpriteNode()
    var shape: SKShapeNode!
    var label: SKLabelNode!
    
    let firstNode = SKNode()
    let nonTexturedSpriteNodeFirst = SKSpriteNode()
    let nonTexturedSpriteNodeSecond = SKSpriteNode()
    let texturedSpriteNode = SKSpriteNode(imageNamed: "ColourRing")
    let firstNodeExample = SKNode()
 
    let square = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        
        square.color = UIColor.red
        square.size = CGSize(width: 64, height: 64)
        square.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        /*
         Create AND EXECUTE ACTIONS HERE
        */
        self.backgroundColor = UIColor.magenta
        square.color = UIColor.yellow
        square.size = CGSize(width: 128, height: 128)
        square.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(square)
        
        
        createShape()
        createLabel()
        createNode()
        
        
        addChild(firstNodeExample)
        nonTexturedSpriteNodeSecond.addChild(texturedSpriteNode)
        nonTexturedSpriteNodeFirst.addChild(nonTexturedSpriteNodeSecond)
        firstNode.addChild(nonTexturedSpriteNodeFirst)
        addChild(firstNode)
        
        firstNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        nonTexturedSKSpriteNode()
        texturedSKSpriteNode()
    }
    
    
    func texturedSKSpriteNode()
    {
        //texturedSpriteNode.size = CGSize(width: 64, height: 64)
        //texturedSpriteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    
    func nonTexturedSKSpriteNode()
    {
        nonTexturedSpriteNodeFirst.name = "first"
        nonTexturedSpriteNodeFirst.color = UIColor.darkGray
        nonTexturedSpriteNodeFirst.size = CGSize(width: 512, height: 1080)
        nonTexturedSpriteNodeFirst.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        nonTexturedSpriteNodeSecond.name = "second"
        nonTexturedSpriteNodeSecond.color = UIColor.red
        nonTexturedSpriteNodeSecond.size = CGSize(width: 250, height: 250)
        nonTexturedSpriteNodeSecond.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nonTexturedSpriteNodeSecond.position = CGPoint(x: 0, y: -325)
    }
    
    
    func createShape()
    {
        shape = SKShapeNode(rectOf: CGSize(width: 128, height: 128))
        shape.fillColor = SKColor.white
        shape.fillTexture = SKTexture(imageNamed: "ColourRing")
        shape.position = CGPoint(x: self.frame.midX, y: 10)
        self.addChild(shape)
    }
    
    
    func createLabel()
    {
        label = SKLabelNode()
        label.text = "Colour Catcher"
        label.fontSize = 32.0
        label.fontName = "AvenirNext-Bold"
        label.fontColor = UIColor.green
        label.position = CGPoint(x: self.frame.midX, y: 750)//self.frame.midY)
        self.addChild(label)
    }
    
    func createNode()
    {
        node.size = CGSize(width: 32, height: 32)
        node.color = UIColor.blue
        node.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let location = touches.first?.location(in: self)
        {
            if node.contains(location)
            {
                node.size = CGSize(width: node.size.width * 2, height: node.size.height * 2)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let location = touches.first?.location(in: self)
        {
            if node.contains(location)
            {
                node.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let location = touches.first?.location(in: self)
        {
            if node.contains(location)
            { node.size = CGSize(width: node.size.width * 0.5, height: node.size.height * 0.5) }
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("Touch Has Been Cancelled")
    }
}
