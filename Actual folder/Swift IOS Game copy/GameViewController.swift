//  GameViewController.swift
//  Swift IOS Game
//  Created by Ryan Wilkinson on 26/09/19.
//  Copyright © 2019 Ryan Wilkinson. All rights reserved.

import UIKit
import SpriteKit


class GameViewController: UIViewController
{
    override func viewDidLoad()
    {   super.viewDidLoad()

        if let view = self.view as! SKView?
        {// Load the SKScene from 'GameScene.sks'
            let scene = MenuScreen(size: view.bounds.size)
            //let skScene = MainMenu(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(scene)
            // Properties
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
}
