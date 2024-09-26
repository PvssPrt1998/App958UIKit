import SpriteKit

class GameScene3: SKScene {
    
    deinit {
        print("GameScene3deinit")
    }
    
    let gameModel: GameModel
    
    var bombSound = SKAction.playSoundFileNamed("bombExplosion.mp3", waitForCompletion: false)
    var wheelSound = SKAudioNode(fileNamed: "WheelSpinning.mp3")
    var loseSound = SKAction.playSoundFileNamed("wheelLose.mp3", waitForCompletion: false)
    var win = SKAction.playSoundFileNamed("platformAndWheelWin.mp3", waitForCompletion: false)
    var backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "backgroundSound.mp3")
    
    private var twistButtonDisabled = true
    
    var initialPoint: CGPoint
    var coordinatesArray: Array<Array<CGPoint>>
    
    var exitButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.ExitButton.rawValue))
    var twistButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.TwistButton.rawValue))
    var gameStatusBar = SKSpriteNode(texture: SKTexture(imageNamed: Images.GameStatusBar.rawValue))
    var wheel = SKSpriteNode(texture: SKTexture(imageNamed: Images.Wheel.rawValue))
    var stopButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.StopButton.rawValue))
    
    var bomb1 = SKSpriteNode(texture: SKTexture(imageNamed: Images.bomb.rawValue))
    var bomb2 = SKSpriteNode(texture: SKTexture(imageNamed: Images.bomb.rawValue))
    
    var gameOver = SKSpriteNode(texture: SKTexture(imageNamed: Images.GameOver.rawValue))
    var gameOverExit = SKSpriteNode(texture: SKTexture(imageNamed: Images.GameOverExit.rawValue))
    var gameOverContinue = SKSpriteNode(texture: SKTexture(imageNamed: Images.ContinueButton.rawValue))
    
    var pointer = SKSpriteNode(texture: SKTexture(imageNamed: Images.WheelPointer.rawValue))
    
    var ball: SKSpriteNode
    
    var gameOverBalance = SKLabelNode(fontNamed: "FasterOne-Regular")
    
    var coin1: SKSpriteNode
    var coin2: SKSpriteNode
    var coin3: SKSpriteNode
    
    var addCoinLabel = SKLabelNode(fontNamed: "FugazOne-Regular")
    var balanceLabel = SKLabelNode(fontNamed: "FugazOne-Regular")
    var hpLabel = SKLabelNode(fontNamed: "FugazOne-Regular")
    
    var heart1 = SKSpriteNode(texture: SKTexture(imageNamed: Images.heart.rawValue))
    var heart2 = SKSpriteNode(texture: SKTexture(imageNamed: Images.heart.rawValue))
    
    var explosion = SKSpriteNode(texture: SKTexture(imageNamed: Images.Explosion.rawValue))
    
    var ballIndex = 0
    
    var shadowBackground = SKSpriteNode()
    
    var platformsArray: Array<SKSpriteNode> = [
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.Platform.rawValue))
    ]
    
    var gameOverHPButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.GameOverHPButton.rawValue))
    
    var background = SKSpriteNode(imageNamed: Images.Map3.rawValue)
    
    init(size: CGSize, gameModel: GameModel) {
        self.gameModel = gameModel
        gameModel.hp = 3
        self.ball = SKSpriteNode(texture: SKTexture(imageNamed: gameModel.ballsArray[gameModel.selectedBallIndex].imageTitle))
        self.coin1 = SKSpriteNode(texture: SKTexture(imageNamed: gameModel.coinArray[gameModel.selectedCoinIndex].imageTitle))
        self.coin2 = SKSpriteNode(texture: SKTexture(imageNamed: gameModel.coinArray[gameModel.selectedCoinIndex].imageTitle))
        self.coin3 = SKSpriteNode(texture: SKTexture(imageNamed: gameModel.coinArray[gameModel.selectedCoinIndex].imageTitle))
        self.initialPoint = CGPoint(x: size.width * 0.2, y: size.height + 100)
        self.coordinatesArray = [
            [
                CGPoint(x: size.width * 0.7, y: size.height * 0.75),
                CGPoint(x: size.width * 0.3, y: size.height * 0.9),
                CGPoint(x: size.width * 0.8, y: size.height * 0.85),
            ],
            
            [
                CGPoint(x: size.width * 0.37, y: size.height * 0.71),
                CGPoint(x: size.width * 0.68, y: size.height * 0.71),
                CGPoint(x: size.width * 0.35, y: size.height * 0.7)
            ],
            
            [
                CGPoint(x: size.width * 0.14, y: size.height * 0.6),
                CGPoint(x: size.width * 0.20, y: size.height * 0.65),
                CGPoint(x: size.width * 0.15, y: size.height * 0.63)
            ],
            [
                CGPoint(x: size.width * 0.3, y: size.height * 0.49),
                CGPoint(x: size.width * 0.1, y: size.height * 0.51),
                CGPoint(x: size.width * 0.14, y: size.height * 0.50)
            ],
            [
                CGPoint(x: size.width * 0.65, y: size.height * 0.45),
                CGPoint(x: size.width * 0.65, y: size.height * 0.45),
                CGPoint(x: size.width * 0.65, y: size.height * 0.45)
            ],
            [
                CGPoint(x: size.width * 0.4, y: size.height * 0.37),
                CGPoint(x: size.width * 0.67, y: size.height * 0.35),
                CGPoint(x: size.width * 0.61, y: size.height * 0.34)
            ],
            [
                CGPoint(x: size.width * 0.15, y: size.height * 0.3),
                CGPoint(x: size.width * 0.3, y: size.height * 0.38),
                CGPoint(x: size.width * 0.15, y: size.height * 0.3)
            ],
            [
                CGPoint(x: size.width * 0.15, y: size.height * 0.1),
                CGPoint(x: size.width * 0.13, y: size.height * 0.25),
                CGPoint(x: size.width * 0.7, y: size.height * 0.15)
            ],
            [
                CGPoint(x: size.width * 0.2, y: -size.height * 0.2),
                CGPoint(x: size.width * 0.2, y: size.height * 0),
                CGPoint(x: size.width * 0.2, y: -size.height * 0.1)
            ]
        ]
        super.init(size: size)
        backgroundMusic.autoplayLooped = true
        backgroundMusic.run(SKAction.changeVolume(to: 0.1, duration: 0))
        addChild(backgroundMusic)
        configureBackground()
        configureExitButton()
        configureTwistButton()
        configurePlatforms()
        configureGameStatusBar()
        configureShadowBackground()
        configureWheel()
        configureBall()
        configureBombs()
        configureExplosion()
        configureCoins()
        configureHearts()
        configureAddCoinLabel()
        configureGameOver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureGameOver() {
        gameOver.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //gameOverBalance.position = CGPoint(x: 0, y: gameOver.size.height * 0.1)
        gameOver.name = "GameOver"
        gameOverBalance.text = "\(gameModel.balance)"
        gameOverBalance.zPosition = 9
        gameOverBalance.position = CGPoint(x: gameOver.size.width * 0.04, y: gameOver.size.height * 0.165)
        gameOverBalance.fontSize = 24
        gameOverBalance.horizontalAlignmentMode = .center
        gameOverBalance.fontColor = .white
        gameOver.addChild(gameOverBalance)
        gameOver.alpha = 0
        gameOver.zPosition = 6
        gameOverExit.zPosition = 7
        gameOverExit.name = "GameOverExit"
        gameOver.addChild(gameOverExit)
        gameOverHPButton.zPosition = 7
        gameOverHPButton.name = "GameOverHPButton"
        gameOverExit.position = CGPoint(x: 0, y: -gameOver.size.height * 0.23)
        gameOver.addChild(gameOverHPButton)
        self.addChild(gameOver)
    }
    
    private func configureAddCoinLabel() {
        addCoinLabel.text = "+1"
        addCoinLabel.zPosition = 4
        addCoinLabel.fontSize = 20
        addCoinLabel.horizontalAlignmentMode = .center
        addCoinLabel.fontColor = .white
        addCoinLabel.alpha = 0
        addChild(addCoinLabel)
    }
    
    private func showWheel() {
        wheel.zRotation = 0
        stopButton.alpha = 1
        wheel.alpha = 1
        pointer.alpha = 1
        shadowBackground.alpha = 1
    }
    
    private func configureHearts() {
        heart1.position = CGPoint(x: size.width * 0.3, y: size.height * 0.49 + platformsArray[0].size.height * 0.25)
        heart1.name = "heart3"
        heart1.zPosition = 2
        addChild(heart1)
        heart2.position = CGPoint(x: size.width * 0.15, y: size.height * 0.1 + platformsArray[0].size.height * 0.25)
        heart2.name = "heart7"
        heart2.zPosition = 2
        addChild(heart2)
    }
    
    private func configureCoins() {
        coin1.position = CGPoint(x: size.width * 0.14, y: size.height * 0.6 + platformsArray[0].size.height * 0.25)
        coin1.name = "coin2"
        coin1.zPosition = 2
        addChild(coin1)
        coin2.position = CGPoint(x: size.width * 0.65, y: size.height * 0.45 + platformsArray[0].size.height * 0.25)
        coin2.name = "coin4"
        coin2.zPosition = 2
        addChild(coin2)
        coin3.position = CGPoint(x: size.width * 0.15, y: size.height * 0.3 + platformsArray[0].size.height * 0.25)
        coin3.name = "coin6"
        coin3.zPosition = 2
        addChild(coin3)
    }
    
    private func configureWheel() {
        //wheel.position = CGPoint(x: shadowBackground.frame.minX, y: shadowBackground.frame.midY)
        wheel.zPosition = 6
        shadowBackground.alpha = 1
        shadowBackground.addChild(wheel)
        pointer.position = CGPoint(x: 0, y: wheel.size.height * 0.45)
        pointer.zPosition = 7
        shadowBackground.addChild(pointer)
        configureStopButton()
        stopButton.alpha = 0
        wheel.alpha = 0
        pointer.alpha = 0
        shadowBackground.alpha = 0
    }
    
    private func configureStopButton() {
        stopButton.zPosition = 7
        stopButton.name = "StopButton"
        shadowBackground.addChild(stopButton)
    }
    
    private func configureBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        self.addChild(background)
    }
    
    private func configureShadowBackground() {
        shadowBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        shadowBackground.size = CGSize(width: size.width, height: size.height)
        shadowBackground.color = .black.withAlphaComponent(0.7)
        shadowBackground.alpha = 0
        shadowBackground.zPosition = 5
        addChild(shadowBackground)
    }
    
    private func configureExitButton() {
        let safeAreaTop = self.view?.window?.windowScene?.windows.first?.safeAreaInsets.top ?? 16
        //exitButton.size = CGSize(width: 164, height: 40)
        exitButton.position = CGPoint(x: self.frame.midX, y: self.frame.height - safeAreaTop - 20)
        exitButton.name = "ExitButton"
        exitButton.zPosition = 6
        self.addChild(exitButton)
    }
    
    private func configureTwistButton() {
        twistButton.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.15)
        twistButton.alpha = 0.5
        twistButton.name = "TwistButton"
        twistButton.zPosition = 4
        self.addChild(twistButton)
    }
    
    private func configureGameStatusBar() {
        let safeAreaTop = self.view?.window?.windowScene?.windows.first?.safeAreaInsets.top ?? 16
        gameStatusBar.position = CGPoint(x: self.frame.midX, y: self.frame.height - safeAreaTop - 74)
        gameStatusBar.name = "GameStatusBar"
        gameStatusBar.zPosition = 3
        self.addChild(gameStatusBar)
        
        balanceLabel.text = "\(gameModel.balance)"
        balanceLabel.zPosition = 4
        balanceLabel.fontSize = 24
        balanceLabel.horizontalAlignmentMode = .center
        balanceLabel.fontColor = .white
        balanceLabel.position = CGPoint(x: -gameStatusBar.size.width * 0.1, y: -gameStatusBar.size.height * 0.2)
        gameStatusBar.addChild(balanceLabel)
        
        hpLabel.text = "\(gameModel.hp)"
        hpLabel.zPosition = 4
        hpLabel.fontSize = 24
        hpLabel.horizontalAlignmentMode = .center
        hpLabel.fontColor = .white
        hpLabel.position = CGPoint(x: gameStatusBar.size.width * 0.3, y: -gameStatusBar.size.height * 0.2)
        gameStatusBar.addChild(hpLabel)
    }
    
    private func configureBombs() {
        configureBomb1()
        configureBomb2()
    }
    
    private func configureBomb1() {
        bomb1.position = CGPoint(x: size.width * 0.37, y: size.height * 0.71 + platformsArray[0].size.height * 0.35)
        bomb1.name = "bomb1"
        bomb1.zPosition = 2
        addChild(bomb1)
    }
    
    private func configureBomb2() {
        bomb2.zPosition = 2
        bomb2.name = "bomb5"
        bomb2.position = CGPoint(x: size.width * 0.4, y: size.height * 0.37 + platformsArray[0].size.height * 0.35)
        addChild(bomb2)
    }
    
    private func configureExplosion() {
        explosion.zPosition = 5
        explosion.position = CGPoint(x: size.width / 2, y: size.height / 2)
        explosion.alpha = 0
        addChild(explosion)
    }
    
    private func configurePlatforms() {
        configurePlatform(x: self.size.width * 0.7, y: self.size.height * 0.75, index: 0)
        configurePlatform(x: self.size.width * 0.37, y: self.size.height * 0.71, index: 1)
        configurePlatform(x: self.size.width * 0.14, y: self.size.height * 0.6, index: 2)
        configurePlatform(x: self.size.width * 0.3, y: self.size.height * 0.49, index: 3)
        configurePlatform(x: self.size.width * 0.65, y: self.size.height * 0.45, index: 4)
        configurePlatform(x: self.size.width * 0.4, y: self.size.height * 0.37, index: 5)
        configurePlatform(x: self.size.width * 0.15, y: self.size.height * 0.3, index: 6)
        configurePlatform(x: self.size.width * 0.15, y: self.size.height * 0.1, index: 7)
    }
    
    private func configurePlatform(x: CGFloat, y: CGFloat, index: Int) {
        platformsArray[index].position = CGPoint(x: x, y: y)
        platformsArray[index].name = "Platform\(index)"
        platformsArray[index].zPosition = 1
        self.addChild(platformsArray[index])
    }
    
    private func configureBall() {
        ball.position = initialPoint
        ball.zPosition = 3
        addChild(ball)
        let path = UIBezierPath()
        path.move(to: initialPoint)
        let rotationAction = SKAction.repeatForever(SKAction.rotate(byAngle: -CGFloat.pi * 2.0, duration: 0.5))
        ball.run(rotationAction, withKey: "ballSpin")
        path.addCurve(to: CGPoint(x: coordinatesArray[ballIndex][0].x, y: coordinatesArray[ballIndex][0].y + platformsArray[0].size.height * 0.2),
                      controlPoint1: CGPoint(x: coordinatesArray[ballIndex][1].x, y: coordinatesArray[ballIndex][1].y),
                      controlPoint2: CGPoint(x: coordinatesArray[ballIndex][2].x, y: coordinatesArray[ballIndex][2].y))
        ball.run(SKAction.follow(path.cgPath,
                                        asOffset: false,
                                        orientToPath: false,
                                 speed: 200.0)) {
            self.ball.removeAction(forKey: "ballSpin")
            self.bombsCheck()
            self.coinsCheck()
            self.heartsCheck()
            self.twistButtonDisabled = false
            self.twistButton.alpha = 1
        }
    }
    
    private func moveBall(check: Bool = true, completion: (()->Void)? = nil) {
        if ballIndex >= 8 {
            self.twistButtonDisabled = false
            self.twistButton.alpha = 1
            self.coinsCheck()
            self.heartsCheck()
            self.bombsCheck()
            return
        }
        self.twistButtonDisabled = true
        twistButton.alpha = 0.5
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: coordinatesArray[ballIndex][0].x, y: coordinatesArray[ballIndex][0].y + platformsArray[0].size.height * 0.2))
        if ballIndex < 8 {
            ballIndex += 1
        }
        
        path.addCurve(to: CGPoint(x: coordinatesArray[ballIndex][0].x, y: coordinatesArray[ballIndex][0].y + platformsArray[0].size.height * 0.2),
                      controlPoint1: CGPoint(x: coordinatesArray[ballIndex][1].x, y: coordinatesArray[ballIndex][1].y + platformsArray[0].size.height * 0.2),
                      controlPoint2: CGPoint(x: coordinatesArray[ballIndex][2].x, y: coordinatesArray[ballIndex][2].y + platformsArray[0].size.height * 0.2))
        
        // use the beizer path in an action
        let rotationAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi * 2.0, duration: 0.5))
        ball.run(rotationAction, withKey: "ballSpin")
        ball.run(SKAction.follow(path.cgPath,
                                        asOffset: false,
                                        orientToPath: false,
                                 speed: 200.0)) {
            self.ball.removeAction(forKey: "ballSpin")
            if check {
                self.twistButtonDisabled = false
                self.twistButton.alpha = 1
                
                self.coinsCheck()
                self.heartsCheck()
                self.bombsCheck()
            }
            if self.ballIndex == 8 {
                let transition = SKTransition.moveIn(with: .down, duration: 0.2)
                let menuScene = GameScene4(size: self.size, gameModel: self.gameModel)
                menuScene.scaleMode = .aspectFill
                guard self.scene != nil else { return }
                self.scene!.view?.presentScene(menuScene, transition: transition)
            }
            completion?()
        }
    }
    
    private func coinsCheck() {
        if "coin\(ballIndex)" == coin1.name && coin1.parent != nil {
            run(win)
            coin1.run(SKAction.fadeAlpha(to: 0, duration: 0.5)) {
                self.incrementBalance()
                self.coin1.removeFromParent()
            }
            addCoinLabel.position = CGPoint(x: size.width * 0.14, y: size.height * 0.6 + platformsArray[0].size.height * 0.25)
            addCoinLabel.alpha = 1
            addCoinLabel.run(SKAction.sequence([SKAction.move(to: CGPoint(x: size.width * 0.14, y: size.height * 0.6 + platformsArray[0].size.height * 0.25 + 50), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.5)]))
        }
        
        if "coin\(ballIndex)" == coin2.name && coin2.parent != nil {
            run(win)
            coin2.run(SKAction.fadeAlpha(to: 0, duration: 0.5)) {
                self.incrementBalance()
                self.coin2.removeFromParent()
            }
            addCoinLabel.position = CGPoint(x: size.width * 0.65, y: size.height * 0.45 + platformsArray[0].size.height * 0.25)
            addCoinLabel.alpha = 1
            addCoinLabel.run(SKAction.sequence([SKAction.move(to: CGPoint(x: size.width * 0.65, y: size.height * 0.45 + platformsArray[0].size.height * 0.25 + 50), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.5)]))
        }
        
        if "coin\(ballIndex)" == coin3.name && coin3.parent != nil {
            run(win)
            coin3.run(SKAction.fadeAlpha(to: 0, duration: 0.5)) {
                self.incrementBalance()
                self.coin3.removeFromParent()
            }
            addCoinLabel.position = CGPoint(x: size.width * 0.15, y: size.height * 0.3 + platformsArray[0].size.height * 0.25)
            addCoinLabel.alpha = 1
            addCoinLabel.run(SKAction.sequence([SKAction.move(to: CGPoint(x: size.width * 0.15, y: size.height * 0.3 + platformsArray[0].size.height * 0.25 + 50), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.5)]))
        }
    }
    
    private func heartsCheck() {
        if "heart\(ballIndex)" == heart1.name && heart1.parent != nil {
            heart1.run(SKAction.fadeAlpha(to: 0, duration: 0.5)) {
                self.incrementHP()
                self.heart1.removeFromParent()
            }
            addCoinLabel.position = CGPoint(x: size.width * 0.3, y: size.height * 0.49 + platformsArray[0].size.height * 0.25)
            addCoinLabel.alpha = 1
            addCoinLabel.run(SKAction.sequence([SKAction.move(to: CGPoint(x: size.width * 0.3, y: size.height * 0.49 + platformsArray[0].size.height * 0.25 + 50), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.5)]))
        }
        if "heart\(ballIndex)" == heart2.name && heart2.parent != nil {
            heart2.run(SKAction.fadeAlpha(to: 0, duration: 0.5)) {
                self.incrementHP()
                self.heart2.removeFromParent()
            }
            addCoinLabel.position = CGPoint(x: size.width * 0.15, y: size.height * 0.1 + platformsArray[0].size.height * 0.25)
            addCoinLabel.alpha = 1
            addCoinLabel.run(SKAction.sequence([SKAction.move(to: CGPoint(x: size.width * 0.15, y: size.height * 0.1 + platformsArray[0].size.height * 0.25 + 50), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.5)]))
        }
    }
    
    private func showGameOver(_ lose: Bool) {
        gameOverBalance.text = "\(gameModel.balance)"
        if gameModel.balance < 20 {
            gameOverHPButton.alpha = 0.4
        }
        
        exitButton.zPosition = 4 //after this window change to 6
        shadowBackground.alpha = 1
        gameOver.alpha = 1
    }
    
    private func dismissGameOver() {
        gameOver.alpha = 0
        balanceLabel.text = "\(gameModel.balance)"
        shadowBackground.alpha = 0
        exitButton.zPosition = 6
    }
    
    private func incrementBalance() {
        gameModel.saveBalance(gameModel.balance + 1)
        balanceLabel.text = "\(gameModel.balance)"
    }
    
    private func incrementHP() {
        gameModel.hp += 1
        hpLabel.text = "\(gameModel.hp)"
    }
    
    private func moveBallBack(_ check: Bool = true, completion: (()->Void)? = nil) {
        guard ballIndex > 0 else {
            self.twistButtonDisabled = false
            self.twistButton.alpha = 1
            return }
        self.twistButtonDisabled = true
        twistButton.alpha = 0.5
        let path = UIBezierPath()
        path.move(to: CGPoint(x: coordinatesArray[ballIndex][0].x, y: coordinatesArray[ballIndex][0].y + platformsArray[0].size.height * 0.2))
        if ballIndex > 0 {
            ballIndex += -1
        }
        path.addCurve(to: CGPoint(x: coordinatesArray[ballIndex][0].x, y: coordinatesArray[ballIndex][0].y + platformsArray[0].size.height * 0.2),
                      controlPoint1: CGPoint(x: coordinatesArray[ballIndex + 1][2].x, y: coordinatesArray[ballIndex + 1][2].y + platformsArray[0].size.height * 0.2),
                      controlPoint2: CGPoint(x: coordinatesArray[ballIndex + 1][1].x, y: coordinatesArray[ballIndex + 1][1].y + platformsArray[0].size.height * 0.2))
        // use the beizer path in an action
        let rotationAction = SKAction.repeatForever(SKAction.rotate(byAngle: -CGFloat.pi * 2.0, duration: 0.5))
        ball.run(rotationAction, withKey: "ballSpin")
        ball.run(SKAction.follow(path.cgPath,
                                        asOffset: false,
                                        orientToPath: false,
                                 speed: 200.0)) {
            self.ball.removeAction(forKey: "ballSpin")
            if check {
                self.twistButtonDisabled = false
                self.twistButton.alpha = 1
                
                self.heartsCheck()
                self.coinsCheck()
                if self.bomb1Check() {
                    self.explosion.alpha = 1
                    self.bomb1.removeFromParent()
                    let seq = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 1)])
                    self.explosion.run(seq)
                }
                if self.bomb2Check() {
                    self.explosion.alpha = 1
                    self.bomb2.removeFromParent()
                    let seq = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 1)])
                    self.explosion.run(seq)
                }
            }
            
            completion?()
        }
    }
    
    private func bombExplosion() {
        self.run(bombSound)
        self.explosion.alpha = 1
        let seq = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 1)])
        self.explosion.run(seq)
        self.gameModel.hp -= 1
        self.hpLabel.text = "\(gameModel.hp)"
        if gameModel.hp <= 0 {
            showGameOver(true)
        } else {
            if ballIndex > 0 {
                moveBallBack()
            }
        }
    }
    
    private func bombsCheck() {
        if self.bomb1Check() {
            self.run(bombSound)
            self.explosion.alpha = 1
            self.bomb1.removeFromParent()
            let seq = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 1)])
            self.explosion.run(seq)
            self.gameModel.hp -= 1
            self.hpLabel.text = "\(self.gameModel.hp)"
            if self.gameModel.hp <= 0 {
                self.showGameOver(true)
            } else {
                self.moveBallBack()
            }
            
        }
        if self.bomb2Check() {
            self.run(bombSound)
            self.explosion.alpha = 1
            self.bomb2.removeFromParent()
            let seq = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 1)])
            self.explosion.run(seq)
            self.gameModel.hp -= 1
            self.hpLabel.text = "\(self.gameModel.hp)"
            if self.gameModel.hp <= 0 {
                self.showGameOver(true)
            } else {
                self.moveBallBack()
            }
        }
    }
    
    private func bomb1Check() -> Bool {
        if "bomb\(ballIndex)" == bomb1.name && bomb1.parent != nil {
            return true
        } else {
            return false
        }
    }
    
    private func bomb2Check() -> Bool {
        if "bomb\(ballIndex)" == bomb2.name && bomb2.parent != nil {
            return true
        } else {
            return false
        }
    }
    
    private func dismissWheel() {
        stopButton.alpha = 0
        wheel.alpha = 0
        pointer.alpha = 0
        shadowBackground.alpha = 0
    }
    
    var stopButtonPressed = false
    
    func gameOverRestoreHP() {
        guard gameModel.balance >= 20 else { return }
        gameModel.hp += 1
        hpLabel.text = "\(gameModel.hp)"
        gameModel.balance -= 20
        balanceLabel.text = "\(gameModel.balance)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let location = firstTouch.location(in: self)
        
        let node = self.atPoint(location)
        
        if !twistButtonDisabled {
            if node.name == "TwistButton" {
                wheelSound = SKAudioNode(fileNamed: "WheelSpinning.mp3")
                wheelSound.run(SKAction.changeVolume(to: 0.5, duration: 0))
                addChild(wheelSound)
            
                
                //moveBall()
                //self.moveBall(check: false){self.moveBall(check: true)}//3
                //bombExplosion()
//                self.moveBallBack(false) { self.moveBallBack(false) {self.moveBallBack(true)} }
//                return
                //moveBall()
                showWheel()
                wheel.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi * 2.0, duration: 0.5)), withKey: "rotateWheel")
            }
        }
        
        if node.name == "StopButton" && !stopButtonPressed {
            wheelSound.run(SKAction.stop())
            wheelSound.removeFromParent()
            stopButtonPressed = true
            stopButton.alpha = 0.7
            wheel.removeAction(forKey: "rotateWheel")
            var degree = ((self.wheel.zRotation * 180) / CGFloat.pi).truncatingRemainder(dividingBy: 360)
            self.run(SKAction.wait(forDuration: 1)) {
                self.stopButtonPressed = false
                self.dismissWheel()
                switch degree {
                case 0...9: self.moveBall()
                case 9.000001...36: self.bombExplosion()
                case 36.000001...55: self.incrementHP()
                case 55.000001...81: self.run(self.win); self.incrementBalance()
                case 81.000001...101: self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: true)}}//3
                case 101.000001...126: self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: true)}}}//4
                case 126.000001...144: self.incrementHP()
                case 145.000001...170: self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: true)}}}}//5
                case 170.000001...189: {
                    if self.ballIndex > 0 {
                        self.run(self.loseSound)
                        self.moveBallBack(false) { self.moveBallBack(false) {self.moveBallBack(true)} }//-3
                    }
                }()
                case 189.000001...214: self.bombExplosion()
                case 214.000001...233: self.incrementHP()
                case 233.000001...258: self.run(self.win); self.incrementBalance()
                case 258.000001...278: {
                    if self.ballIndex > 0 {
                        self.run(self.loseSound)
                        self.moveBallBack()
                    }
                }()
                    
                case 278.000001...303: self.self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: false){self.moveBall(check: true)}}}//4
                case 303.000001...323: self.incrementHP()
                case 323.000001...350: self.moveBall(check: false){self.moveBall(check: true)}//2
                case 350.000001...360: self.moveBall()
                default: {}()
                    //
                }
            }
        }
        
        if node.name == "ExitButton" {
            let transition = SKTransition.crossFade(withDuration: 0.3)
            let menuScene = MenuScene(size: self.size, gameModel: gameModel)
            menuScene.scaleMode = .aspectFill
            guard self.scene != nil else { return }
            self.scene!.view?.presentScene(menuScene, transition: transition)
        }
        
        if node.name == "GameOverExit" {
            let transition = SKTransition.crossFade(withDuration: 0.3)
            let menuScene = MenuScene(size: self.size, gameModel: gameModel)
            menuScene.scaleMode = .aspectFill
            guard self.scene != nil else { return }
            self.scene!.view?.presentScene(menuScene, transition: transition)
        }
        
        if node.name == "GameOverHPButton" && gameModel.balance >= 20 {
            dismissGameOver()
            gameOverRestoreHP()
        }
    }
}

// 1: 351 to 360 to 9
// 2: 10 to 36
// 3: 37 to 55
// 4: 56 to 81
// 5: 82 to 101
// 6: 102 to 126
// 7: 127 to 144
// 8: 145 to 170
// 9: 171 to 189
// 10: 190 to 214
// 11: 215 to 233
// 12: 234 to 258
// 13: 259 to 278
// 14: 279 to 303
// 15: 304 to 323
// 16: 324 to 350

