import SpriteKit

class ShopScene: SKScene {
    
    let gameModel: GameModel
    
    var background = SKSpriteNode(imageNamed: Images.ShopBackground.rawValue)
    var exitButton = SKSpriteNode(texture: SKTexture(imageNamed: Images.ExitButton.rawValue))
    var shopWindow = SKSpriteNode(texture: SKTexture(imageNamed: Images.ShopWindow.rawValue))
    
    var coinsSprites: Array<SKSpriteNode>
    var ballsSprites: Array<SKSpriteNode>
    
    var balanceLabel = SKLabelNode(fontNamed: "FugazOne-Regular")
    
    var shopFieldPrices: Array<SKLabelNode> = [
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular"),
        SKLabelNode(fontNamed: "FasterOne-Regular")
    ]
    
    var shopFields: Array<SKSpriteNode> = [
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.shopField.rawValue))
    ]
    
    var shopSelectedFields: Array<SKSpriteNode> = [
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.selected.rawValue))
    ]
    
    var shopChooseFields: Array<SKSpriteNode> = [
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue)),
        SKSpriteNode(texture: SKTexture(imageNamed: Images.choose.rawValue))
    ]
    
    //MARK: - coins
    var silverCoin = SKSpriteNode(texture: SKTexture(imageNamed: Images.coin2.rawValue))
    
    init(size: CGSize, gameModel: GameModel) {
        self.gameModel = gameModel
        
        self.coinsSprites = gameModel.coinArray.map({ coin in
            SKSpriteNode(texture: SKTexture(imageNamed: coin.imageTitle))
        })
        self.ballsSprites = gameModel.ballsArray.map({ ball in
            SKSpriteNode(texture: SKTexture(imageNamed: ball.imageTitle))
        })
        super.init(size: size)
        configureBackground()
        configureExitButton()
        configureShopWindow()
        configureCoins()
        configureBalls()
        configureShopFields()
        configureSelectedFields()
        configureChooseFields()
        configureBalanceLabel()
        configurePrices()
        recalc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func recalc() {
        gameModel.coinArray.forEach { coin in
            if coin.id == gameModel.selectedCoinIndex {
                shopSelectedFields[coin.id].alpha = 1
                shopChooseFields[coin.id].alpha = 0
                shopFields[coin.id].alpha = 0
                shopSelectedFields[coin.id].name = "Active"
                shopChooseFields[coin.id].name = "Inactive"
                shopFields[coin.id].name = "Inactive"
            } else {
                if coin.available {
                    shopChooseFields[coin.id].alpha = 1
                    shopSelectedFields[coin.id].alpha = 0
                    shopFields[coin.id].alpha = 0
                    shopSelectedFields[coin.id].name = "Inactive"
                    shopChooseFields[coin.id].name = "Active"
                    shopFields[coin.id].name = "Inactive"
                } else {
                    shopFields[coin.id].alpha = 1
                    shopSelectedFields[coin.id].alpha = 0
                    shopChooseFields[coin.id].alpha = 0
                    if coin.price > gameModel.balance {
                        shopFields[coin.id].alpha = 0.7
                    }
                    shopSelectedFields[coin.id].name = "Inactive"
                    shopChooseFields[coin.id].name = "Inactive"
                    shopFields[coin.id].name = "Active"
                }
            }
        }
        
        gameModel.ballsArray.forEach { ball in
            if ball.id == gameModel.selectedBallIndex {
                shopSelectedFields[ball.id + 6].alpha = 1
                shopChooseFields[ball.id + 6].alpha = 0
                shopFields[ball.id + 6].alpha = 0
            } else {
                if ball.available {
                    shopSelectedFields[ball.id + 6].alpha = 0
                    shopChooseFields[ball.id + 6].alpha = 1
                    shopFields[ball.id + 6].alpha = 0
                } else {
                    shopSelectedFields[ball.id + 6].alpha = 0
                    shopChooseFields[ball.id + 6].alpha = 0
                    shopFields[ball.id + 6].alpha = 1
                    if ball.price > gameModel.balance {
                        shopFields[ball.id + 6].alpha = 0.7
                    }
                }
            }
        }
    }
    
    private func configureBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        self.addChild(background)
    }
    
    private func configurePrices() {
        configurePrice(shopFieldPrices[0], text: "50", x: shopFields[0].size.width * 0.06, y: -shopFields[0].size.height * 0.12, parent: shopFields[0], index: 0)
        configurePrice(shopFieldPrices[1], text: "50", x: shopFields[0].size.width * 0.06, y: -shopFields[1].size.height * 0.12, parent: shopFields[1], index: 1)
        configurePrice(shopFieldPrices[2], text: "50", x: shopFields[0].size.width * 0.06, y: -shopFields[2].size.height * 0.12, parent: shopFields[2], index: 2)
        configurePrice(shopFieldPrices[3], text: "100", x: shopFields[0].size.width * 0.06, y: -shopFields[3].size.height * 0.12, parent: shopFields[3], index: 3)
        configurePrice(shopFieldPrices[4], text: "100", x: shopFields[0].size.width * 0.06, y: -shopFields[4].size.height * 0.12, parent: shopFields[4], index: 4)
        configurePrice(shopFieldPrices[5], text: "100", x: shopFields[0].size.width * 0.06, y: -shopFields[5].size.height * 0.12, parent: shopFields[5], index: 5)
        configurePrice(shopFieldPrices[6], text: "200", x: shopFields[0].size.width * 0.06, y: -shopFields[6].size.height * 0.12, parent: shopFields[6], index: 6)
        configurePrice(shopFieldPrices[7], text: "200", x: shopFields[0].size.width * 0.06, y: -shopFields[7].size.height * 0.12, parent: shopFields[7], index: 7)
        configurePrice(shopFieldPrices[8], text: "200", x: shopFields[0].size.width * 0.06, y: -shopFields[8].size.height * 0.12, parent: shopFields[8], index: 8)
    }
    
    private func configurePrice(_ label: SKLabelNode, text: String, x: CGFloat, y: CGFloat, parent: SKSpriteNode, index: Int) {
        label.text = text
        label.zPosition = 3
        label.fontSize = 17
        label.fontColor = .white
        label.position = CGPoint(x: x, y: y)
        label.name = "price\(index)"
        parent.addChild(label)
    }
    
    private func configureBalanceLabel() {
        balanceLabel.text = "\(gameModel.balance)"
        balanceLabel.zPosition = 2
        balanceLabel.fontSize = 24
        balanceLabel.horizontalAlignmentMode = .center
        balanceLabel.fontColor = .white
        balanceLabel.position = CGPoint(x: shopWindow.size.width * 0.025, y: shopWindow.size.height * 0.363)
        shopWindow.addChild(balanceLabel)
    }
    
    private func configureShopWindow() {
        //shopWindow.size = CGSize(width: 368, height: 414)
        shopWindow.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        shopWindow.zPosition = 1
        shopWindow.name = "ShopWindow"
        self.addChild(shopWindow)
    }
    
    private func configureCoins() {
        configureCoin(coinsSprites[0], x: -(shopWindow.size.width * 0.235), y: shopWindow.size.height * 0.24, index: 0)
        configureCoin(coinsSprites[1], x: 0, y: shopWindow.size.height * 0.24,index: 1)
        configureCoin(coinsSprites[2], x: shopWindow.size.width * 0.235, y: shopWindow.size.height * 0.24, index: 2)
        configureCoin(coinsSprites[3], x: -(shopWindow.size.width * 0.235), y: shopWindow.size.height * 0.02, index: 3)
        configureCoin(coinsSprites[4], x: 0, y: shopWindow.size.height * 0.02, index: 4)
        configureCoin(coinsSprites[5], x: shopWindow.size.width * 0.235, y: shopWindow.size.height * 0.02, index: 5)
    }
    
    private func configureBalls() {
        configureBall(ballsSprites[0], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.195, index: 0)
        configureBall(ballsSprites[1], x: 0, y: -shopWindow.size.height * 0.195, index: 1)
        configureBall(ballsSprites[2], x: shopWindow.size.width * 0.235, y: -shopWindow.size.height * 0.195, index: 2)
    }
    
    private func configureShopFields() {
        configureShopField(shopFields[0], x: -(shopWindow.size.width * 0.235), y: shopWindow.size.height * 0.16, index: 0)
        configureShopField(shopFields[1], x: 0, y: shopWindow.size.height * 0.16, index: 1)
        configureShopField(shopFields[2], x: (shopWindow.size.width * 0.232), y: shopWindow.size.height * 0.16, index: 2)
        configureShopField(shopFields[3], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.055, index: 3)
        configureShopField(shopFields[4], x: 0, y: -shopWindow.size.height * 0.055, index: 4)
        configureShopField(shopFields[5], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.055, index: 5)
        configureShopField(shopFields[6], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.275, index: 6)
        configureShopField(shopFields[7], x: 0, y: -shopWindow.size.height * 0.275, index: 7)
        configureShopField(shopFields[8], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.275, index: 8)
    }
    
    private func configureSelectedFields() {
        configureSelectedField(shopSelectedFields[0], x: -(shopWindow.size.width * 0.235), y: shopWindow.size.height * 0.16, index: 0)
        configureSelectedField(shopSelectedFields[1], x: 0, y: shopWindow.size.height * 0.16, index: 1)
        configureSelectedField(shopSelectedFields[2], x: (shopWindow.size.width * 0.232), y: shopWindow.size.height * 0.16, index: 2)
        configureSelectedField(shopSelectedFields[3], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.055, index: 3)
        configureSelectedField(shopSelectedFields[4], x: 0, y: -shopWindow.size.height * 0.055, index: 4)
        configureSelectedField(shopSelectedFields[5], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.055, index: 5)
        configureSelectedField(shopSelectedFields[6], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.275, index: 6)
        configureSelectedField(shopSelectedFields[7], x: 0, y: -shopWindow.size.height * 0.275, index: 7)
        configureSelectedField(shopSelectedFields[8], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.275, index: 8)
    }
    
    private func configureCoin(_ coin: SKSpriteNode, x: CGFloat, y: CGFloat, index: Int) {
        coin.size = CGSize(width: 37, height: 34)
        //coin.position = CGPoint(x: x, y: y)
        coin.zPosition = 2
        coin.name = "coinIndex\(index)"
        let coinWrapper = SKSpriteNode()
        coinWrapper.position = CGPoint(x: x, y: y - shopWindow.size.height * 0.01)
        coin.position = CGPoint(x: 0, y: shopWindow.size.height * 0.01)
        coinWrapper.zPosition = 5
        coinWrapper.name = "coinWrapperIndex\(index)"
        coinWrapper.size = CGSize(width: shopWindow.size.height * 0.18, height: shopWindow.size.height * 0.20)
        shopWindow.addChild(coinWrapper)
        coinWrapper.addChild(coin)
       
    }
    
    private func configureBall(_ ball: SKSpriteNode, x: CGFloat, y: CGFloat, index: Int) {
        ball.size = CGSize(width: 37, height: 34)
        //ball.position = CGPoint(x: x, y: y)
        ball.zPosition = 2
        ball.name = "ballIndex\(index)"
        let ballWrapper = SKSpriteNode()
        ballWrapper.zPosition = 5
        ballWrapper.alpha = 1
        ballWrapper.position = CGPoint(x: x, y: y - shopWindow.size.height * 0.01)
        ballWrapper.size = CGSize(width: shopWindow.size.height * 0.18, height: shopWindow.size.height * 0.20)
        ball.position = CGPoint(x: 0, y: shopWindow.size.height * 0.01)
        ballWrapper.name = "ballWrapperIndex\(index)"
        ballWrapper.addChild(ball)
        //ball.name = "ballIndex\(index)"
        shopWindow.addChild(ballWrapper)
    }
    
    private func configureShopField(_ shopField: SKSpriteNode, x: CGFloat, y: CGFloat, index: Int) {
        shopField.position = CGPoint(x: x, y: y)
        shopField.alpha = 0
        shopField.zPosition = 2
        shopField.name = "shopFieldIndex\(index)"
        shopWindow.addChild(shopField)
    }
    
    private func configureSelectedField(_ shopField: SKSpriteNode, x: CGFloat, y: CGFloat, index: Int) {
        shopField.position = CGPoint(x: x, y: y)
        shopField.alpha = 0
        shopField.zPosition = 2
        shopField.name = "selectedFieldIndex\(index)"
        shopWindow.addChild(shopField)
    }
    
    private func configureChooseFields() {
        configureChooseField(shopChooseFields[0], x: -(shopWindow.size.width * 0.235), y: shopWindow.size.height * 0.16, index: 0)
        configureChooseField(shopChooseFields[1], x: 0, y: shopWindow.size.height * 0.16, index: 1)
        configureChooseField(shopChooseFields[2], x: (shopWindow.size.width * 0.232), y: shopWindow.size.height * 0.16, index: 2)
        configureChooseField(shopChooseFields[3], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.055, index: 3)
        configureChooseField(shopChooseFields[4], x: 0, y: -shopWindow.size.height * 0.055, index: 4)
        configureChooseField(shopChooseFields[5], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.055, index: 5)
        configureChooseField(shopChooseFields[6], x: -(shopWindow.size.width * 0.235), y: -shopWindow.size.height * 0.275, index: 6)
        configureChooseField(shopChooseFields[7], x: 0, y: -shopWindow.size.height * 0.275, index: 7)
        configureChooseField(shopChooseFields[8], x: (shopWindow.size.width * 0.232), y: -shopWindow.size.height * 0.275, index: 8)
    }
    
    private func configureChooseField(_ shopField: SKSpriteNode, x: CGFloat, y: CGFloat, index: Int) {
        shopField.position = CGPoint(x: x, y: y)
        shopField.alpha = 0
        shopField.zPosition = 2
        shopField.name = "chooseFieldIndex\(index)"
        shopWindow.addChild(shopField)
    }
    
    private func configureExitButton() {
        let safeAreaTop = self.view?.window?.windowScene?.windows.first?.safeAreaInsets.top ?? 16
        exitButton.position = CGPoint(x: self.frame.midX, y: self.size.height - safeAreaTop - 30)
        exitButton.name = "ExitButton"
        self.addChild(exitButton)
    }
    
    func coinTapped(_ index: Int) {
        if gameModel.coinArray[index].id != gameModel.selectedCoinIndex {
            if gameModel.coinArray[index].available {
                //gameModel.selectedCoinIndex = gameModel.coinArray[index].id
                gameModel.saveSelectedCoin(index)
                recalc()
            } else {
                if gameModel.balance >= gameModel.coinArray[index].price {
                    //gameModel.balance -= gameModel.coinArray[index].price
                    gameModel.saveBalance(gameModel.balance - gameModel.coinArray[index].price)
                    gameModel.saveCoinAvailalbe(index)
                    //gameModel.coinArray[index].available = true
                    gameModel.saveSelectedCoin(index)
                    //gameModel.selectedCoinIndex = gameModel.coinArray[index].id
                    balanceLabel.text = "\(gameModel.balance)"
                    recalc()
                }
            }
        }
    }
    
    func ballTapped(_ index: Int) {
        if gameModel.ballsArray[index].id != gameModel.selectedBallIndex {
            if gameModel.ballsArray[index].available {
                //gameModel.selectedBallIndex = gameModel.ballsArray[index].id
                gameModel.saveSelectedBall(index)
                recalc()
            } else {
                if gameModel.balance >= gameModel.ballsArray[index].price {
                    //gameModel.balance -= gameModel.ballsArray[index].price
                    gameModel.saveBalance(gameModel.balance - gameModel.ballsArray[index].price)
                    gameModel.saveBallAvailable(index)
                    //gameModel.ballsArray[index].available = true
                    //gameModel.selectedBallIndex = gameModel.ballsArray[index].id
                    gameModel.saveSelectedBall(index)
                    balanceLabel.text = "\(gameModel.balance)"
                    recalc()
                }
            }
        }
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
        
        if node.name == "ballIndex0" || node.name == "ballWrapperIndex0" || node.name == "price6" {
            ballTapped(0)
        }
        if node.name == "ballIndex1" || node.name == "ballWrapperIndex1" || node.name == "price7" {
            ballTapped(1)
        }
        if node.name == "ballIndex2" || node.name == "ballWrapperIndex2" || node.name == "price8" {
            ballTapped(2)
        }
        if node.name == "coinIndex0" || node.name == "coinWrapperIndex0" || node.name == "price0" {
            coinTapped(0)
        }
        if node.name == "coinIndex1" || node.name == "coinWrapperIndex1" || node.name == "price1" {
           coinTapped(1)
        }
        if node.name == "coinIndex2" || node.name == "coinWrapperIndex2" || node.name == "price2" {
            coinTapped(2)
        }
        if node.name == "coinIndex3" || node.name == "coinWrapperIndex3" || node.name == "price3" {
            coinTapped(3)
        }
        if node.name == "coinIndex4" || node.name == "coinWrapperIndex4" || node.name == "price4" {
            coinTapped(4)
        }
        if node.name == "coinIndex5" || node.name == "coinWrapperIndex5" || node.name == "price5" {
            coinTapped(5)
        }
    }
}

