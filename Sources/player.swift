

import Foundation

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

let playerURL = URL(fileURLWithPath: "\(gameDir)/cache/player.json")

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
      try encoded.write(to: playerURL)
      print("Personagem criado com sucesso!")
    } catch {
      print("Erro ao salvar o personagem: \(error)")
    }
  }
}

func loadCharacter() -> Player? {
  do {
    let data = try Data(contentsOf: playerURL)
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
      try encoded.write(to: playerURL)
      print("Estatisticas atualizadas com sucesso!")
    } catch {
      print("Erro ao atualizar as estatisticas: \(error)")
    }
  }
}
