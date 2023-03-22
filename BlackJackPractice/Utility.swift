//
//  Utility.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/22/23.
//

import Foundation

class Utility {
    static func randomCard() -> Int {
        let cardValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        return cardValues.randomElement()!
    }

    enum Action: String {
        case stand = "STAND"
        case hit = "HIT"
        case double = "DOUBLE"
        case split = "SPLIT"
    }

    
    static func shouldSplitCards(playerCard1: Int, playerCard2: Int, dealerCard: Int) -> (Bool, String) {
        assert(playerCard1 == playerCard2, "The player cards should be the same");
        // Always split aces and 8s
        if playerCard1 == 1 || playerCard1 == 8 {
            return (true, "Always split aces and 8s.")
        }
        // Never split 10s and 5s
        if playerCard1 == 5 || playerCard2 >= 10 {
            return (false, "Never split 10s and 5s.")
        }
        // Split 2s, 3s, 7s against 2-7
        if playerCard1 == 2 || playerCard1 == 3 || playerCard1 == 7 {
            if dealerCard >= 2 && dealerCard <= 7 {
                return (true, "Split 2s, 3s, 7s against 2-7.")
            } else {
                return (false, "Split 2s, 3s, 7s against 2-7.")
            }
        }
        // Split 4s against 5 or 6
        if playerCard1 == 4 {
            if dealerCard == 5 || dealerCard == 6 {
                return (true, "Split 4s against 5 or 6.")
            } else {
                return (false, "Split 4s against 5 or 6.")
            }
        }
        // Split 6s against 2-6
        if playerCard1 == 6 {
            if dealerCard >= 2 && dealerCard <= 6 {
                return (true, "Split 6s against 2-6.")
            } else {
                return (false, "Split 6s against 2-6.")
            }
        }
        // Split 9s against 2-6 and 8-9
        if playerCard1 == 9 {
            if dealerCard >= 2 && dealerCard <= 6 || dealerCard >= 8 && dealerCard <= 9 {
                return (true, "Split 9s against 2-6 and 8-9.")
            } else {
                return (false, "Split 9s against 2-6 and 8-9.")
            }
        }
        
        return (false, "No specific rule for this situation.")
    }
    
    static func getActionOnSoftCount(playerCard1: Int, playerCard2: Int, dealerCard: Int) -> (action: Action, message: String) {
        assert(playerCard1 == 1 || playerCard2 == 1)
        if playerCard1 != 1 {
            return getActionOnSoftCount(playerCard1: playerCard2, playerCard2: playerCard1, dealerCard: dealerCard)
        }

        if playerCard2 == 1 {
            return (action: .split, message: "Always split aces")
        }
        if playerCard2 == 2 || playerCard2 == 3 {
            if dealerCard >= 5 && dealerCard <= 6 {
                return (action: .double, message: "Double soft 13-14 against 5-6, otw hit")
            } else {
                return (action: .hit, message: "Double soft 13-14 against 5-6, otw hit")
            }
        }
        if playerCard2 == 4 || playerCard2 == 5 {
            if dealerCard >= 4 && dealerCard <= 6 {
                return (action: .double, message: "Double soft 15-16 against 4-6, otw hit")
            } else {
                return (action: .hit, message: "Double soft 15-16 against 4-6, otw hit")
            }
        }
        if playerCard2 == 6 {
            if dealerCard >= 3 && dealerCard <= 6 {
                return (action: .double, message: "Double soft 17 against 3-6, otw hit")
            } else {
                return (action: .hit, message: "Double soft 17 against 3-6, otw hit")
            }
        }
        if playerCard2 == 7 {
            if dealerCard >= 2 && dealerCard <= 6 {
                return (action: .double, message: "Soft 18: double against 2-6, stands against 7-8, hits against 9, 10, Ace. If it can't double against 2-6, it stands")
            } else if dealerCard == 7 || dealerCard == 8 {
                return (action: .stand, message: "Soft 18: double against 2-6, stands against 7-8, hits against 9, 10, Ace. If it can't double against 2-6, it stands")
            } else {
                return (action: .hit, message: "Soft 18: double against 2-6, stands against 7-8, hits against 9, 10, Ace. If it can't double against 2-6, it stands")
            }
        }
        if playerCard2 == 8 {
            if dealerCard == 6 {
                return (action: .double, message: "Soft 19: double against 6, otw stand")
            } else {
                return (action: .stand, message: "Soft 19: double against 6, otw stand")
            }
        }
        if playerCard2 >= 9 {
            return (action: .stand, message: "Soft 20-21: stand")
        }

        return (action: .hit, message: "NO RULE")
    }


    static func getAction(playerCard1: Int, playerCard2: Int, dealerCard: Int) -> (action: Action, message: String) {
        if playerCard1 == playerCard2 {
            let (shouldSplit, reason) = shouldSplitCards(playerCard1: playerCard1, playerCard2: playerCard2, dealerCard: dealerCard)
            if (shouldSplit) {
                return (action: .split, message: reason)
            }
        }

        if playerCard1 == 1 || playerCard2 == 1 {
            return getActionOnSoftCount(playerCard1: playerCard1, playerCard2: playerCard2, dealerCard: dealerCard)
        }

        if playerCard1 + playerCard2 >= 17 {
            return (action: .stand, message: "17-21: stand")
        }

        if playerCard1 + playerCard2 >= 13 {
            if dealerCard >= 2 && dealerCard <= 6 {
                return (action: .stand, message: "13-16: stand against 2-6, otw hit")
            } else {
                return (action: .hit, message: "13-16: stand against 2-6, otw hit")
            }
        }

        if playerCard1 + playerCard2 >= 12 {
            if dealerCard >= 4 && dealerCard <= 6 {
                return (action: .stand, message: "12: stand against 4-6, otw hit")
            } else {
                return (action: .hit, message: "12: stand against 4-6, otw hit")
            }
        }

        if playerCard1 + playerCard2 >= 11 {
            return (action: .double, message: "11: double")
        }

        if playerCard1 + playerCard2 >= 10 {
            if dealerCard >= 2 && dealerCard <= 9 {
                return (action: .double, message: "10: double against 2-9, otw hit")
            } else {
                return (action: .hit, message: "10: double against 2-9, otw hit")
            }
        }

        if playerCard1 + playerCard2 >= 9 {
            if dealerCard >= 3 && dealerCard <= 6 {
                return (action: .double, message: "9: double against 3-6, otw hit")
            } else {
                return (action: .hit, message: "9: double against 3-6, otw hit")
            }
        }

        if playerCard1 + playerCard2 <= 8 {
            return (action: .hit, message: "8 or less: hit")
        }
        
        return (action:. hit, message: "UNK")
    }
}
