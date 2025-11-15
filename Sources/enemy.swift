

import Foundation

struct Enemy : Codable {
  let name: String
  let health: Int
  let attack: Int
  let xp: Int
  let coins: Int
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
