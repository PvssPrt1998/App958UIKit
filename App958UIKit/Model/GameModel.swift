import Foundation

final class GameModel {
    
    var maps: Array<Map> = [
        Map(id: 0, available: true),
        Map(id: 1, available: false),
        Map(id: 2, available: false),
        Map(id: 3, available: false)
    ]
    
    let lstr = Lstr()
    
    var selectedBallIndex: Int = 0
    var selectedCoinIndex: Int = 0
    
    var hp = 3
    var balance = 0
    
    var ballsArray: Array<Ball> = [
        Ball(id: 0, imageTitle: Images.ball1.rawValue, price: 0, available: true),
        Ball(id: 1, imageTitle: Images.ball2.rawValue, price: 200, available: false),
        Ball(id: 2, imageTitle: Images.ball3.rawValue, price: 200, available: false)
    ]
    var coinArray: Array<Coin> = [
        Coin(id: 0, imageTitle: Images.coin1.rawValue, price: 0, available: true),
        Coin(id: 1, imageTitle: Images.coin2.rawValue, price: 50, available: false),
        Coin(id: 2, imageTitle: Images.coin3.rawValue, price: 50, available: false),
        Coin(id: 3, imageTitle: Images.coin5.rawValue, price: 100, available: false),
        Coin(id: 4, imageTitle: Images.coin6.rawValue, price: 100, available: false),
        Coin(id: 5, imageTitle: Images.coin7.rawValue, price: 100, available: false)
    ]
    
    init() {
        if let selectedBallId = try? lstr.fetchSelectedBall() {
            selectedBallIndex = selectedBallId
        }
        if let selectedCoinId = try? lstr.fetchSelectedCoin() {
            selectedCoinIndex = selectedCoinId
        }
        if let balanceC = try? lstr.fetchBalance() {
            balance = balanceC
        }
        if let bA = try? lstr.fetchBallAvailable() {
            bA.forEach { IB in
                ballsArray[IB.0].available = IB.1
            }
        }
        if let cA = try? lstr.fetchCoinAvailable() {
            cA.forEach { IB in
                coinArray[IB.0].available = IB.1
            }
        }
        if let maps = try? lstr.fetchMaps() {
            maps.forEach { IB in
                self.maps[IB.0].available = IB.1
            }
        }
    }
    
    func saveBalance(_ balance: Int) {
        self.balance = balance
        lstr.createOrEditBalance(balance)
    }
    
    func saveSelectedBall(_ id: Int) {
        selectedBallIndex = id
        lstr.createOrEditSelectedBall(id)
    }
    
    func saveSelectedCoin(_ id: Int) {
        selectedCoinIndex = id
        lstr.createOrEditSelectedCoin(id)
    }
    
    func saveBallAvailable(_ index: Int) {
        ballsArray[index].available = true
        lstr.createOrEditBallAvailable(ballsArray[index])
    }
    
    func saveCoinAvailalbe(_ index: Int) {
        coinArray[index].available = true
        lstr.createOrEditCoinAvailable(coinArray[index])
    }
    
    func makeMapAvailableIfNeeded(_ id: Int) {
        if !maps[id].available {
            maps[id].available = true
            lstr.createOrEditMap(maps[id])
        }
    }
}

class Item {
    let id: Int
    let imageTitle: String
    let price: Int
    var available: Bool
    
    init(id: Int, imageTitle: String, price: Int, available: Bool) {
        self.id = id
        self.imageTitle = imageTitle
        self.price = price
        self.available = available
    }
}

class Coin: Item {
    
}

class Ball: Item {
    
}

class Map {
    let id: Int
    var available: Bool
    
    init(id: Int, available: Bool) {
        self.id = id
        self.available = available
    }
}
