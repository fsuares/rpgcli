
import Foundation

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
    let lore = try String(contentsOf: loreUrl, encoding: .utf8)
    return lore
  } catch {
    print("Erro ao carregar o lore da missao: \(error)")
    return nil
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
