import Foundation

let gameDir = "/Users/fernando.aqsuares/rpgcli/rpgcli"

let url = URL(fileURLWithPath: "\(gameDir)/cache/player.json")
let encoder = JSONEncoder()
let decoder = JSONDecoder()

struct Player : Codable {
  let name: String
  let classe: String
  let coins: Int
  let level: Int
  let experience: Int
  let health: Int
  let strength: Int
  let defense: Int
  let mana: Int
  let items: [String:Int]
}

struct Enemy : Codable {
  let name: String
  let health: Int
  let attack: Int
  let xp: Int
  let coins: Int
}

func getUserInput() -> String {
  if let input = readLine() {
    return input
  }
  return "Erro: entrada invalida"
}

func showMenu() {
  print("\n====== Menu Principal =======")
  print("1. Criar personagem")
  print("2. Carregar personagem")
  print("3. Sair do Jogo")
  print("=============================\n")
}

func showPlayerMenu() {
  print("\n=========== Menu ===========")
  print("1. Estatisticas do Jogador")
  print("2. Ver inventario")
  print("3. Loja")
  print("4. Missoes")
  print("5. Sair do Jogo")
  print("============================\n")
}

func showMissionMenu() {
  print("\n======= Missoes Disponiveis =======")
  print("1. Missao Facil")
  print("2. Missao Media")
  print("3. Missao Dificil")
  print("4. Voltar ao Menu Anterior")
  print("===================================\n")
}

func createCharacter() {
  print("Qual o nome do seu heroi: ")
  let name = getUserInput()
  print("Escolha a classe do seu heroi (Guerreiro, Mago, Arqueiro): ")
  let classe = getUserInput()
  let (health, strength, defense, mana, weapon) : (Int, Int, Int, Int, String)

  switch classe.lowercased() {
  case "guerreiro":
    health = 150
    strength = 15
    defense = 10
    mana = 50
    weapon = "espada"
  case "mago":
    health = 100
    strength = 8
    defense = 5
    mana = 150
    weapon = "cajado"
  case "arqueiro":
    health = 120
    strength = 12
    defense = 7
    mana = 80
    weapon = "arco"
  default:
    print("Classe invalida. Definindo como Guerreiro por padrao.")
    health = 150
    strength = 15
    defense = 10
    mana = 50
    weapon = "espada"
  }

  let newPlayer = Player(name: name, classe: classe, coins: 500, level: 1, experience: 0, health: health, strength: strength, defense: defense,mana: mana, items: [weapon: 1, "pocao": 5])
  if let encoded = try? encoder.encode(newPlayer) {
    do {
      try encoded.write(to: url)
      print("Personagem criado com sucesso!")
    } catch {
      print("Erro ao salvar o personagem: \(error)")
    }
  }
}

func loadCharacter() -> Player? {
  do {
    let data = try Data(contentsOf: url)
    let player = try decoder.decode(Player.self, from: data)
    return player
  } catch {
    print("Erro ao carregar o personagem: \(error)")
    return nil
  }
}

func updatePlayerStats(_ player: Player) {
  if let encoded = try? encoder.encode(player) {
    do {
      try encoded.write(to: url)
      print("Estatisticas atualizadas com sucesso!")
    } catch {
      print("Erro ao atualizar as estatisticas: \(error)")
    }
  }
}

func updateEnemyStats(_ enemy: Enemy, _ filename: String) {
  let mission = URL(fileURLWithPath: "\(gameDir)/cache/\(filename).json")
  if let encoded = try? encoder.encode(enemy) {
    do {
      try encoded.write(to: mission)
      print("Estatisticas atualizadas com sucesso!")
    } catch {
      print("Erro ao atualizar as estatisticas: \(error)")
    }
  }
}

func loadMissionData(filename: String) -> Enemy? {
  let missionUrl = URL(fileURLWithPath: "\(gameDir)/cache/\(filename).json")
  do {
    let data = try Data(contentsOf: missionUrl)
    let mission = try decoder.decode(Enemy.self, from: data)
    return mission
  } catch {
    print("Erro ao carregar os dados da missao: \(error)")
    return nil
  }
}

func loadLore(filename: String) -> String? {
  let loreUrl = URL(fileURLWithPath: "\(gameDir)/cache/\(filename).txt")
  do {
    let lore = try String(contentsOf: loreUrl)
    return lore
  } catch {
    print("Erro ao carregar o lore da missao: \(error)")
    return nil
  }
}

func showBattleMenu(){
    print("\n============= Acoes ==============")
    print("1. Atacar")
    print("2. Usar pocao")
    print("===================================\n")
}

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

func missionSelector() {
  showMissionMenu()
  let choice = getUserInput()
    if let player = loadCharacter(){
        switch choice {
        case "1":
          if let lore = loadLore(filename: "easyMission"),
          let mission = loadMissionData(filename: "easyMission") {
            print("\n============ Lore ============\n")
            print(lore)
            print("=============================\n")
            print("Missao: Derrote \(mission.name)!")
            print("Descricao: Derrote o Rato-Rei que esta aterrorizando a vila.")
            print("Vida do Inimigo: \(mission.health)")
            print("Ataque do Inimigo: \(mission.attack)")
            print("Recompensa de Experiencia: \(mission.xp) XP")
            print("Recompensa em Coins: \(mission.coins) Moedas de ouro\n")
              if battleSystem(player, mission, "easyMission") {
                  print("Parabens voce derrotou \(mission.name)!")
                  print("Recompensas:")
                  print("\(mission.xp) XP e \(mission.coins) moedas de ouro")
              } else {
                  print("Voce foi derrotado, foi encontrado a beira da morte e salvo por um nom samaritano.")
                  print("Se encontra com apenas 20 pontos de vida.")
                  print("Deve se recuperar antes da sua proxima aventura.")
              }
            return
          }
          break
        case "2":
          if let lore = loadLore(filename: "mediumMission"),
          let mission = loadMissionData(filename: "mediumMission") {
            print("\n============ Lore ============\n")
            print(lore)
            print("=============================\n")
            print("Missao: Enfrente \(mission.name)!")
            print("Descricao: Enfrente Meliath, a driade corrompida que ameaca a floresta sagrada.")
            print("Vida do Inimigo: \(mission.health)")
            print("Ataque do Inimigo: \(mission.attack)")
            print("Recompensa de Experiencia: \(mission.xp) XP")
            print("Recompensa em Coins: \(mission.coins) Moedas de ouro\n")
              if battleSystem(player, mission, "mediumMission") {
                  print("Parabens voce derrotou \(mission.name)!")
                  print("Recompensas:")
                  print("\(mission.xp) XP e \(mission.coins) moedas de ouro")
              } else {
                  print("Voce foi derrotado, foi encontrado a beira da morte e salvo por um nom samaritano.")
                  print("Se encontra com apenas 20 pontos de vida.")
                  print("Deve se recuperar antes da sua proxima aventura.")
              }
            return
          }
          break
        case "3":
          if let lore = loadLore(filename: "hardMission"),
          let mission = loadMissionData(filename: "hardMission") {
            print("\n============ Lore ============\n")
            print(lore)
            print("=============================\n")
            print("Missao: Derrote \(mission.name)!")
            print("Descricao: Derrote Balgor, o guardiao de magma que protege as profundezas vulcanicas.")
            print("Vida do Inimigo: \(mission.health)")
            print("Ataque do Inimigo: \(mission.attack)")
            print("Recompensa de Experiencia: \(mission.xp) XP")
            print("Recompensa em Coins: \(mission.coins) Moedas de ouro\n")
              if battleSystem(player, mission, "hardMission") {
                  print("Parabens voce derrotou \(mission.name)!")
                  print("Recompensas:")
                  print("\(mission.xp) XP e \(mission.coins) moedas de ouro")
              } else {
                  print("Voce foi derrotado, foi encontrado a beira da morte e salvo por um nom samaritano.")
                  print("Se encontra com apenas 20 pontos de vida.")
                  print("Deve se recuperar antes da sua proxima aventura.")
              }
            return
          }
          break
        case "4":
          return
        default:
          print("Escolha invalida. Tente novamente.")
          missionSelector()
        }
    }
  }

func main() {
  showMenu()
  let choice = getUserInput()
    switch choice {
    case "1":
      createCharacter()
    case "2":
        if let player = loadCharacter() {
            print("Personagem: \(player.name)")
        }
    case "3":
      print("Saindo do jogo. Ate mais!")
      return
    default:
      print("Escolha invalida. Tente novamente.")
      main()
    }

  while true {
    showPlayerMenu()
    let choice = getUserInput()
    switch choice {
    case "1":
      if let player = loadCharacter() {
        print("Nome: \(player.name)")
        print("Classe: \(player.classe)")
        print("Nivel: \(player.level)")
        print("Experiencia: \(player.experience)")
        print("Saude: \(player.health)")
        print("Forca: \(player.strength)")
        print("Defesa: \(player.defense)")
        print("Mana: \(player.mana)")
        print("Coins: \(player.coins)\n")
      }
    case "2":
      if let player = loadCharacter() {
        print("======== Inventario ========")
        for (item, quantity) in player.items {
          print("\(item): \(quantity)")
        }
        print("============================\n")
      }
    case "3":
      print("Loja nao implementada")
    case "4":
      missionSelector()
    case "5":
      print("Saindo do jogo. Ate mais!")
      return
    default:
      print("Escolha invalida. Tente novamente.")
    }
  }
}


main()
