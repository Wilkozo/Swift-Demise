//  GameScene.swift
//  Swift IOS Game
//  Created by Ryan Wilkinson on 26/09/19.
//  Copyright © 2019 Ryan Wilkinson. All rights reserved.


import UIKit
import SpriteKit
//import GameplayKit


// Actually The Menu Screen
class GameScreen: SKScene
{
    
    
    // Need To Remember...
    private let node = SKSpriteNode()
    
    var longPressGestureRecognizer = UILongPressGestureRecognizer()
    var tapGestureRecognizer = UITapGestureRecognizer()
    var panGestureRecognizer = UIPanGestureRecognizer()
    var nodePosition = CGPoint()
    
    // SETUP FOR MORE EFFICIENT
    // TITLE FUNCTION...
    
    // Gameplay Variables
    var currentmode = 0 // Checks Gamemode
    var RandColour = 0 // Random Colour (Of Ball)
    var GameOver = false // Is The Game Finished?
    var CWheel = SKSpriteNode() // Colour Wheel...
    var Ball: SKShapeNode! // Coloured Ball...
    var BallPos = CGFloat(0)
    var Score = 0 // Score...
    
    
    override func didMove(to view: SKView)
    {
        initialiseTileMapNode()
        
        // Loads The Constantly Changing Background Colour
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.colorize(with: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:1.0), colorBlendFactor: CGFloat(1), duration: 3.5), (SKAction.colorize(with: UIColor(red: 0.35,green: 0.45,blue: 0.375, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 3.5))])))

        // Create Colour Wheel
        createWheel()
        
        // Create Ball...
        createBall()
        
        // Create Some Other Effects
        update(00000.00000000001)
        
        setupGestureRecognizer()
    }

    @objc func pan(sender: UIPanGestureRecognizer)
    {
        let translate = sender.translation(in: self.view)
        var tapLocation = sender.location(in: self.view)
        // map tapLocation
        tapLocation.y = abs(self.frame.height - tapLocation.y)
        if (node.contains(tapLocation))
        {
            node.position = CGPoint(x: node.position.x + translate.x, y: node.position.y - translate.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func tap(sender: UITapGestureRecognizer)
    {
        var tapLocation = sender.location(in: self.view)
        //map tapLocation
        tapLocation.y = abs(self.frame.height - tapLocation.y)
        if (node.contains(tapLocation))
        {
            if node.color == UIColor.blue
            { node.color = UIColor.blue }
            else if node.color == UIColor.yellow
            { node.color = UIColor.blue }
            
            
        }
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer)
    {
        var tapLocation = sender.location(in: self.view)
        //map tapLocation
        tapLocation.y = abs(self.frame.height - tapLocation.y)
        if (sender.state == .began)
        {
            if (node.contains(tapLocation))
            {
                node.size = CGSize(width: 64, height: 64)
            }
        }
    }
    
    func setupLongPressGesture()
    {
        guard let view = view else { return }
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGestureRecognizer.minimumPressDuration = 1
        view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func initialiseTileMapNode()
    {
        let columns = 4
        let rows = 4
        let size = CGSize(width: 64, height: 64)
        
        let tileTexture = SKTexture(imageNamed: "JunglePlatform.png") // Tiles
        let tileDefinition = SKTileDefinition(texture: tileTexture, size: size)
        let tileGroup = SKTileGroup(tileDefinition: tileDefinition)
        
        let tileSet = SKTileSet(tileGroups: [tileGroup])
        let tileMapNode = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: size)
        tileMapNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let tile = tileMapNode.tileSet.tileGroups.first!
        tileMapNode.fill(with: tile)
        self.addChild(tileMapNode)
        
    }
    
    func setupTapGesture()
    {
        guard let view = view else { return }
       tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupPanGesture()
    {
        guard let view = view else { return }
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupGestureRecognizer()
    {
        setupLongPressGesture()
        setupTapGesture()
        setupPanGesture()
    }
    
    
    func createWheel()
    {
        // Sets Sprite
        CWheel = SKSpriteNode(texture: SKTexture(imageNamed: "JungleFloor.png"), size: CGSize(width: 445, height: 445))
        CWheel.position = CGPoint(x: self.frame.midX, y: 150)
        self.addChild(CWheel)
    }
    
    func createBall()
    {
        // Creates Outer Ring
        Ball = SKShapeNode(circleOfRadius: 25.0)
        Ball.fillColor = SKColor.white
        Ball.fillTexture = SKTexture(imageNamed: "DoodleJumpPlayerB.png")
        Ball.position = CGPoint(x: self.frame.midX, y: 800)
       self.addChild(Ball)
    }
    
    // Was Old Node Looking At
    // Getting Edge Buttons For Each Side
    func createNode()
    {
        node.size = CGSize(width: 32, height: 32)
        node.color = UIColor.blue
        node.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(node)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Ball Functions For Dropping Resetting Colour Etc...
        //
        // Chance of new Colour
        // Each Colour Being Set based
        // On New Random Number Which Is Generated
        // After The Ball Has Passed Through The Colpur
        // Wheel...
        
        // Calls Basic Ball Movement
        BallBehaviour()
    }
    
    func BallBehaviour()
    {
        // Dropping Y Pos
        BallPos -= 0.0000000001
        // To Be Added
        // Needs To Drop (Not Using Physics)
        // Y minusing on the y Axis
        // Getting Random Colour
        //
        //Ball.position = CGPoint(x: self.frame.midX, y: BallPos)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first?.location(in: self)
        if node.contains(location!) //
        {// Enlarges the Node...
            //node.size = CGSize(width: node.size.width * 2, height: node.size.height * 2)
            
            let newScene = MenuScreen(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .down, duration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesIncomingScene = false
        }
        else if location!.x < self.frame.width/2
        {
            currentmode -= 1
            if (currentmode <= -1)
            { currentmode = 3 }
            // Rotates the Colour Wheel Around By 90 Degrees Each Time The Right Side Of The Screen Is Pressed...
            CWheel.run(SKAction.rotate(byAngle: CGFloat((3.1415 * 90) / 180) , duration: 0.5))
            if (GameOver == true)
            {
                let newScene = MenuScreen(size: (self.view?.bounds.size)!)
                let transition = SKTransition.crossFade(withDuration: 2)
                self.view?.presentScene(newScene, transition: transition)
                transition.pausesOutgoingScene = true
                transition.pausesIncomingScene = true
            }
        }
        else
        {
            currentmode += 1
            if (currentmode >= 4)
            { currentmode = 0 }
            // Rotates the Colour Wheel Around By -90 Degrees Each Time The Left Side Of The Screen Is Pressed...
            CWheel.run(SKAction.rotate(byAngle: CGFloat (-(3.1415 * 90) / 180) , duration: 0.5))
            
            if (GameOver == true)
            {
                // Update The Score
                let newScene = MenuScreen(size: (self.view?.bounds.size)!)
                let transition = SKTransition.crossFade(withDuration: 2)
                self.view?.presentScene(newScene, transition: transition)
                transition.pausesOutgoingScene = true
                transition.pausesIncomingScene = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {   if let location = touches.first?.location(in: self)
    {   if node.contains(location)
    {  node.position = location  }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {   if let location = touches.first?.location(in: self)
    {   if node.contains(location)
    { node.size = CGSize(width: node.size.width * 0.5, height: node.size.height * 0.5) }
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {   print("Touch Has Been Cancelled")  }
}


// Actually The Game Screen...
class MenuScreen: SKScene
{
    
    //Titles
    var title: SKLabelNode! // Colour
    var title2: SKLabelNode! // Catcher
    
    //Subheaders
    var Play: SKLabelNode! // Play Label
    var HScore: SKLabelNode! // High Score
    var CScore: SKLabelNode! // Current Score
    
    
    
    var TitleLabel = SKLabelNode()
    var Sprite = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        // Create Labels
        
        // Changes the Background Colour
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.colorize(with: UIColor(red: 0.0, green: 0.0, blue: 0.75, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 5), (SKAction.colorize(with: UIColor(red: 0.75, green:0.0, blue: 0.75, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 5))])))
        // Loads The Colour Wheel
        Sprite = SKSpriteNode(texture: SKTexture(imageNamed: "RINGCOLOUR"), size:  CGSize(width: 210, height: 210))
        Sprite.position = CGPoint(x: 210, y: 695)
        addChild(Sprite)
        createLabel() // For Score...
        // Rotates the Colour Ring Indefinately
        Sprite.run(SKAction.repeatForever(SKAction.rotate(byAngle: 3.1415 *  90 / 180, duration: 0.85)))
    }
    func createLabel()
    {
        // Titles
        title = SKLabelNode()
        title2 = SKLabelNode()
        Play = SKLabelNode()
        HScore = SKLabelNode()
        CScore = SKLabelNode()
        
        title.text = "Dank"
        title2.text = "Jump"
        Play.text = ""
        HScore.text = "[PLAY]"
        CScore.text = "[Credits]"
        
        title.fontSize = 25.0
        title2.fontSize = 21.0
        Play.fontSize = 72.0
        HScore.fontSize = 42.0
        CScore.fontSize = 42.0
        
        title.fontName = "AvenirNext-Bold"
        title2.fontName = "AvenirNext-Bold"
        Play.fontName = "AvenirNext-Bold"
        HScore.fontName = "AvenirNext-Bold"
        CScore.fontName = "AvenirNext-Bold"
        
        title.fontColor = UIColor.white
        title2.fontColor = UIColor.white
        Play.fontColor = UIColor.white
        HScore.fontColor = UIColor.white
        CScore.fontColor = UIColor.white
        
        title.position = CGPoint(x: self.frame.midX, y: 705)//self.frame.midY)
        title2.position = CGPoint(x: self.frame.midX, y: 678)//self.frame.midY)
        Play.position = CGPoint(x: self.frame.midX, y: 450)//self.frame.midY)
        HScore.position = CGPoint(x: self.frame.midX, y: 250)//self.frame.midY)
        CScore.position = CGPoint(x: self.frame.midX, y: 150)//self.frame.midY)
        
        self.addChild(title)
        self.addChild(title2)
        self.addChild(Play)
        self.addChild(HScore)
        self.addChild(CScore)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
            let newScene = GameScreen(size: (self.view?.bounds.size)!)
            let transition = SKTransition.crossFade(withDuration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = false
            transition.pausesIncomingScene = false
    }
}
