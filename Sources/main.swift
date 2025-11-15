import Foundation

let gameDir = FileManager.default.currentDirectoryPath
let encoder = JSONEncoder()
let decoder = JSONDecoder()

func getUserInput() -> String {
  if let input = readLine() {
    return input
  }
  return "Erro: entrada invalida"
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
            print(player)
            print(type(of: player))
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
