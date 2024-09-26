import SpriteKit
import StoreKit

class SettingsScene: SKScene {
    
    let gameModel: GameModel
    
    var exitButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.ExitButton.rawValue))
    var background = SKSpriteNode(imageNamed: Images.SettingsBackground.rawValue)
    var usagePolicyButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.UsagePolicyButton.rawValue))
    var rateUsButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.RateUsButton.rawValue))
    var shareAppButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.ShareAppButton.rawValue))
    
    init(size: CGSize, gameModel: GameModel) {
        self.gameModel = gameModel
        super.init(size: size)
        configureBackground()
        configureExitButton()
        configureUsagePolicyButton()
        configureRateUsButton()
        configureShareAppButton()
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
    
    private func configureExitButton() {
        let safeAreaTop = self.view?.window?.windowScene?.windows.first?.safeAreaInsets.top ?? 54
        //exitButton.size = CGSize(width: 164, height: 40)
        exitButton.position = CGPoint(x: self.frame.midX, y: self.frame.height - safeAreaTop - 20)
        exitButton.name = "ExitButton"
        self.addChild(exitButton)
    }
    
    private func configureUsagePolicyButton() {
        //exitButton.size = CGSize(width: 164, height: 40)
        usagePolicyButton.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.65)
        usagePolicyButton.name = "UsagePolicyButton"
        self.addChild(usagePolicyButton)
    }
    
    private func configureShareAppButton() {
        //exitButton.size = CGSize(width: 164, height: 40)
        shareAppButton.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.5)
        shareAppButton.name = "ShareAppButton"
        self.addChild(shareAppButton)
    }
    
    private func configureRateUsButton() {
        rateUsButton.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.35)
        rateUsButton.name = "RateUsButton"
        self.addChild(rateUsButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let location = firstTouch.location(in: self)
        
        let node = self.atPoint(location)
        
        if node.name == "ExitButton" {
            let transition = SKTransition.crossFade(withDuration: 0.1)
            let menuScene = MenuScene(size: self.size, gameModel: gameModel)
            menuScene.scaleMode = .aspectFill
            guard self.scene != nil else { return }
            self.scene!.view?.presentScene(menuScene, transition: transition)
        }
        
        if node.name == "UsagePolicyButton" {
            if let url = URL(string: "https://www.termsfeed.com/live/2e7f6918-9934-4abf-943d-13d6bf7aaa10") {
                UIApplication.shared.open(url)
            }
        }
        
        if node.name == "ShareAppButton" {
            actionSheet()
        }
        
        if node.name == "RateUsButton" {
            SKStoreReviewController.requestReviewInCurrentScene()
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/app/botanopoly-the-gold-rush/id6717572419")  else { return } //TODO: - change link
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
