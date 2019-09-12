//
//  TomoSDK.swift
//  Example
//
//  Created by Admin on 9/3/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Result
enum TRCType{
    case TRC20
    case TRC721
    case TRC21(isApplyIssuer: Bool)
    case Unkwown
}

public struct TRCToken : Decodable {
    let contract: EthereumAddress
    let name: String?
    let symbol: String
    let decimals: Int
    let totalSupply: Double?
    let type: TRCType
    
    private enum TRCTokenCodingKeys: String, CodingKey {
        case hash
        case name
        case symbol
        case decimals
        case totalSupplyNumber
        case type
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TRCTokenCodingKeys.self)
        let address = try container.decode(String.self, forKey: .hash)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.decimals = try container.decode(Int.self, forKey: .decimals)
        self.totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupplyNumber)
        let typeString = try container.decode(String.self, forKey: .type)
        self.contract  = EthereumAddress(string: address)!
        switch typeString.lowercased() {
        case "trc20":
            self.type = TRCType.TRC20
        case "trc21":
            self.type = TRCType.TRC21(isApplyIssuer: false)
        case "trc721":
            self.type = TRCType.TRC721
        default:
            self.type = TRCType.Unkwown
        }
     
    }
    

    
    
}

public enum TomoChainNetwork{
    case Mainnet
    case Testnet
}

public class WalletCore {
    private let tomoKeystoreProtocol: TomoKeystoreProtocol

    init(network: TomoChainNetwork) {
        self.tomoKeystoreProtocol = TomoKeystore(network: network)
    }
    
    func createWallet(completion: @escaping(Result<TomoWallet, TomoKeystoreError>) -> Void){
        tomoKeystoreProtocol.createWallet(completion: completion)
    }
    func getWallet(address: String, completion: @escaping(Result<TomoWallet, TomoKeystoreError>) -> Void) {
        tomoKeystoreProtocol.getWallet(address: address, completion: completion)
    }
    func getAllWallets() -> [TomoWallet] {
        return tomoKeystoreProtocol.getwallets()
    }
    
    
}
