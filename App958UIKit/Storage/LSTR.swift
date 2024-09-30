import Foundation

final class Lstr {
    private let modelName = "DataStorage"
    
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func createOrEditMap(_ map: Map) {
        do {
            let maps = try coreDataStack.managedContext.fetch(MapCoreData.fetchRequest())
            var founded = false
            maps.forEach { mapC in
                if mapC.id == map.id {
                    mapC.available = map.available
                    founded = true
                }
            }
            if !founded {
                let mapCoreData = MapCoreData(context: coreDataStack.managedContext)
                mapCoreData.id = Int32(map.id)
                mapCoreData.available = map.available
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchMaps() throws -> Array<(Int, Bool)> {
        var array: Array<(Int,Bool)> = []
        let maps = try coreDataStack.managedContext.fetch(MapCoreData.fetchRequest())
        maps.forEach { mapC in
            array.append((Int(mapC.id), mapC.available))
        }
        return array
    }
    
    func createOrEditSelectedBall(_ id: Int) {
        do {
            let selectedBalls = try coreDataStack.managedContext.fetch(SelectedBall.fetchRequest())
            if selectedBalls.count > 0 {
                //exists
                selectedBalls[0].selected = Int32(id)
            } else {
                let selectedBall = SelectedBall(context: coreDataStack.managedContext)
                selectedBall.selected = Int32(id)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchSelectedBall() throws -> Int? {
        guard let selectedBall = try coreDataStack.managedContext.fetch(SelectedBall.fetchRequest()).first else { return nil }
        return Int(selectedBall.selected)
    }
    
    func createOrEditSelectedCoin(_ id: Int) {
        do {
            let selectedBalls = try coreDataStack.managedContext.fetch(SelectedCoin.fetchRequest())
            if selectedBalls.count > 0 {
                //exists
                selectedBalls[0].selected = Int32(id)
            } else {
                let selectedBall = SelectedCoin(context: coreDataStack.managedContext)
                selectedBall.selected = Int32(id)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchSelectedCoin() throws -> Int? {
        guard let selectedCoin = try coreDataStack.managedContext.fetch(SelectedCoin.fetchRequest()).first else { return nil }
        return Int(selectedCoin.selected)
    }
    
    func createOrEditBalance(_ balance: Int) {
        do {
            let selectedBalls = try coreDataStack.managedContext.fetch(Balance.fetchRequest())
            if selectedBalls.count > 0 {
                //exists
                selectedBalls[0].value = Int32(balance)
            } else {
                let selectedBall = Balance(context: coreDataStack.managedContext)
                selectedBall.value = Int32(balance)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchBalance() throws -> Int? {
        guard let balance = try coreDataStack.managedContext.fetch(Balance.fetchRequest()).first else { return nil }
        return Int(balance.value)
    }
    
    func createOrEditBallAvailable(_ ball: Ball) {
        do {
            let balls = try coreDataStack.managedContext.fetch(BallAvailable.fetchRequest())
            var founded = false
            balls.forEach { ballC in
                if ballC.id == ball.id {
                    ballC.available = ball.available
                    founded = true
                }
            }
            if !founded {
                let ballAvailable = BallAvailable(context: coreDataStack.managedContext)
                ballAvailable.id = Int32(ball.id)
                ballAvailable.available = ball.available
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchBallAvailable() throws -> Array<(Int,Bool)> {
        var array: Array<(Int,Bool)> = []
        let balls = try coreDataStack.managedContext.fetch(BallAvailable.fetchRequest())
        balls.forEach { ballC in
            array.append((Int(ballC.id), ballC.available))
        }
        return array
    }
    
    func createOrEditCoinAvailable(_ coin: Coin) {
        do {
            let balls = try coreDataStack.managedContext.fetch(CoinAvailable.fetchRequest())
            var founded = false
            balls.forEach { ballC in
                if ballC.id == coin.id {
                    ballC.available = coin.available
                    founded = true
                }
            }
            if !founded {
                let ballAvailable = CoinAvailable(context: coreDataStack.managedContext)
                ballAvailable.id = Int32(coin.id)
                ballAvailable.available = coin.available
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchCoinAvailable() throws -> Array<(Int, Bool)> {
        var array: Array<(Int,Bool)> = []
        let balls = try coreDataStack.managedContext.fetch(CoinAvailable.fetchRequest())
        balls.forEach { ballC in
            array.append((Int(ballC.id), ballC.available))
        }
        return array
    }
    
}
