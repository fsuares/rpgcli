func calcDamage(_ player: Player, _ enemy: Enemy, _ who: Bool, _ filename: String) -> (playerHP: Int, enemyHP: Int){
    var enemyHP = enemy.health
    var playerHP = player.health

    var dice : Int
    if who {
        dice = Int.random(in: 1...20)
        if dice == 20 {
            enemyHP -= player.strength
            print("Voce acerta um golpe critico no \(enemy.name)")
            print("Da: \(player.strength) de dano")
            print("\(enemy.name) agora se encontra com \(enemyHP) pontos de vida")
        } else if dice > 10 && dice < 20 {
            enemyHP -= player.strength
            print("Voce acerta o golpe no \(enemy.name)")
            print("Da: \(player.strength) de dano")
            print("\(enemy.name) agora se encontra com \(enemyHP) pontos de vida")
        } else {
            print("Voce erra o golpe")
            print("Nao da dano algum")
            print("E agora \(enemy.name) tem a chance de te atacar\n")
        }
    } else {
        dice = Int.random(in: 1...20)
        if dice == 20 {
            playerHP -= enemy.attack
            print("\(enemy.name) lhe acerta um golpe critico")
            print("Da: \(enemy.attack) de dano")
            print("Voce se encontra agora com \(playerHP) pontos de vida")
        } else if dice > 10 && dice < 20 {
            playerHP -= enemy.attack
            print("\(enemy.name) lhe acerta um golpe critico")
            print("Da: \(enemy.attack) de dano")
            print("Voce se encontra agora com \(playerHP) pontos de vida")
        } else {
            print("\(enemy.name) erra o golpe")
            print("Nao lhe da dano")
            print("Essa e sua chance de atacar\n")
        }

    }
    return (playerHP, enemyHP)
}

func calcPlayerDamage(_ enemyHP: Int, _ enemyName: String, _ playerST: Int) -> Int{
    return 0
}

func battleSystem(_ player : Player, _ enemy : Enemy, _ filename: String) -> Bool {
    showBattleMenu()
    let choice = getUserInput()
    switch choice{
    case "1":
        return true
    case "2":
        return false
    default:
        return false
    }
}
