//
//  GameSceneJames.swift
//  iceJumper
//
//  Created by James Neeley on 5/21/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import SpriteKit

/////JAMES

extension GameScene {
    
    func setupJames() {
        //initialized
    }
    
    func updateJames() {
        isPlayerMoving()
        updatePlayerPosition()
    }
    
    func updatePlayerPosition() {
        guard let player = player else {return}
        playerY = player.position.y
        playerX = player.position.x
    }
    
    func isPlayerMoving() {
        guard let player = player else {return}
        if player.position.x != playerX || player.position.y != playerY {
            playerMoving = true
        } else {
            playerMoving = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let location = touch.location(in: self)
            touchStartLocation = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let angle = findAngle(StartPoint: touchStartLocation, EndPoint: location)
            playerJumped(Angle: angle)
        }
    }
    
    func findAngle(StartPoint: CGPoint, EndPoint: CGPoint) -> CGFloat{
//        print("Y2: \(EndPoint.y) Y1: \(StartPoint.y),  X2: \(EndPoint.x) X1 \(StartPoint.x)")
        let radians = atan2(StartPoint.y - EndPoint.y, StartPoint.x - EndPoint.x)
        let degree = radians * 180.0 / CGFloat.pi
        return degree
    }
    
    func playerJumped(Angle angle: CGFloat) {
        //        print(angle)
//        if playerMoving == false {
            switch angle {
            case 160...180:
                jumpPlayer(dx: -6, dy: 4)
            case 140...159:
                jumpPlayer(dx: -4.5, dy: 8)
            case 120...139:
                jumpPlayer(dx: -3, dy: 12)
            case 100...119:
                jumpPlayer(dx: -1.5, dy: 16)
            case 80...99:
                jumpPlayer(dx: 0, dy: 20)
            case 60...79:
                jumpPlayer(dx: 1.5, dy: 16)
            case 40...59:
                jumpPlayer(dx: 3, dy: 12)
            case 20...39:
                jumpPlayer(dx: 4.5, dy: 8)
            case 0...19:
                jumpPlayer(dx: 6, dy: 4)
            default:
                return
            }
//        }
    }
    
    func jumpPlayer(dx: CGFloat, dy: CGFloat) {
        guard let player = player else {return}
        player.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }
    
    func resetPlayer() {
        if let player = player {
            player.removeFromParent()
        }
        
        //random color
        let playerLocal = Player(color: Colors.PlumpPurple)
        playerLocal.physicsBody!.mass = 0.02
        playerLocal.position.x = (size.width * 0.04) - (playerLocal.size.width / 2)
        playerLocal.position.y = (size.height / 2) + (playerLocal.size.height / 2)
        playerLocal.zPosition = 2
        player = playerLocal
        guard let player = player else {return}
        addChild(player)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsCatagory.Player | PhysicsCatagory.LoosePad {
            score = 0
            scoreLabel.text = "\(score)"
            youDiedLabel.text = "YOU DIED"
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = self.scaleMode
            let animation = SKTransition.fade(withDuration: 3.0)
            self.view?.presentScene(gameScene, transition: animation)
        } else if collision == PhysicsCatagory.Player | PhysicsCatagory.WinPad {
            score += 1
            scoreLabel.text = "Score: \(score)"
            resetPlayer()
        }
    }
    
    func createPowerUp() {
        
        
    }
    
    func randomNumber(from: UInt32, to: UInt32) -> CGFloat{
        return CGFloat((arc4random() % to))
    }
}















