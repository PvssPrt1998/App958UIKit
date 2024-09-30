import SpriteKit

class MenuScene: SKScene {
    
    let gameModel: GameModel
    var backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "backgroundSound.mp3")
    var background = SKSpriteNode(imageNamed: Images.BgMenuMain.rawValue)
    var playButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.PlayButton.rawValue))
    var shopButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.ShopButton.rawValue))
    var settingsButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.SettingsButton.rawValue))
    
//    override init(size: CGSize) {
//        super.init(size: size)
//
//    }
//    
    init(size: CGSize, gameModel: GameModel) {
        self.gameModel = gameModel
        super.init(size: size)
        backgroundMusic.autoplayLooped = true
        backgroundMusic.run(SKAction.changeVolume(to: 0.1, duration: 0))
        addChild(backgroundMusic)
        configureBackground()
        configurePlayButton()
        configureShopButton()
        configureSettingsButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    private func configureBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        self.addChild(background)
    }
    
    private func configureShopButton() {
        //shopButton.size = CGSize(width: 291, height: 71)
        shopButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 170)
        shopButton.name = "ShopButton"
        self.addChild(shopButton)
    }
    
    private func configureSettingsButton() {
        //settingsButton.size = CGSize(width: 291, height: 71)
        settingsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 77)
        settingsButton.name = "SettingsButton"
        self.addChild(settingsButton)
    }
    
    private func configurePlayButton() {
        //playButton.size = CGSize(width: 274, height: 181)
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 123)
        playButton.name = "PlayButton"
        self.addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let location = firstTouch.location(in: self)
        
        let node = self.atPoint(location)
        
        if node.name == "PlayButton" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            playButton.run(SKAction.fadeAlpha(to: 0.3, duration: 0.05)) {
                let gameScene = GameScene1(size: self.size, gameModel: self.gameModel)
                gameScene.scaleMode = .aspectFill
                guard self.scene != nil else { return }
                self.scene!.view?.presentScene(gameScene, transition: transition)
            }
            
        }
        if node.name == "ShopButton" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            shopButton.run(SKAction.fadeAlpha(to: 0.3, duration: 0.05)) {
                let shopScene = ShopScene(size: self.size, gameModel: self.gameModel)
                shopScene.scaleMode = .fill
                guard self.scene != nil else { return }
                self.scene!.view?.presentScene(shopScene, transition: transition)
            }
        }
        if node.name == "SettingsButton" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            settingsButton.run(SKAction.fadeAlpha(to: 0.3, duration: 0.05)) {
                let settingsScene = SettingsScene(size: self.size, gameModel: self.gameModel)
                settingsScene.scaleMode = .aspectFill
                guard self.scene != nil else { return }
                self.scene!.view?.presentScene(settingsScene, transition: transition)
            }
            
        }
    }
}
