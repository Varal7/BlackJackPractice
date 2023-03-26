//
//  Card.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/25/23.
//

import Foundation

public enum Suit: String, Codable {
    case spades, hearts, diamonds, clubs

    public static func random() -> Suit {
        let cases: [Suit] = [.spades, .hearts, .diamonds, .clubs]
        return cases.randomElement()!
    }
}

public struct Card: Codable {
    public let rank: Int
    public let suit: Suit
    
    public init(rank: Int, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
}
