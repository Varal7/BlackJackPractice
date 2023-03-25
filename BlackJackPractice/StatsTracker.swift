//
//  StatsTracker.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/25/23.
//

import Foundation

struct HandStats: Codable {
    let playerCard1: Card
    let playerCard2: Card
    let dealerCard: Card
    var incorrectCount: Int
    var totalSeen: Int
}

func loadStats() -> [HandStats] {
    let userDefaults = UserDefaults.standard
    if let data = userDefaults.data(forKey: "handStats") {
        let decoder = JSONDecoder()
        if let decodedStats = try? decoder.decode([HandStats].self, from: data) {
            return decodedStats
        }
    }
    return []
}

func saveStats(_ stats: [HandStats]) {
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    if let encodedStats = try? encoder.encode(stats) {
        userDefaults.set(encodedStats, forKey: "handStats")
    }
}
