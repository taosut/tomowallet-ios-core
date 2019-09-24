// Copyright © 2017-2018 Trust.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

@testable import TomoWalletCore
import XCTest

class EthereumAddressTests: XCTestCase {
    func testInvalid() {
        XCTAssertNil(EthereumAddress(string: "abc"))
        XCTAssertNil(EthereumAddress(string: "aaeb60f3e94c9b9a09f33669435e7ef1beaed"))
    }

    func testEIP55() {
        XCTAssertEqual(
            EthereumAddress(data: Data(hexString: "5aaeb6053f3e94c9b9a09f33669435e7ef1beaed")!)!.eip55String,
            "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"
        )
        XCTAssertEqual(
            EthereumAddress(data: Data(hexString: "0x5AAEB6053F3E94C9b9A09f33669435E7Ef1BEAED")!)!.eip55String,
            "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"
        )
        XCTAssertEqual(
            EthereumAddress(data: Data(hexString: "0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359")!)!.eip55String,
            "0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359"
        )
        XCTAssertEqual(
            EthereumAddress(data: Data(hexString: "0xdbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB")!)!.eip55String,
            "0xdbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB"
        )
        XCTAssertEqual(
            EthereumAddress(data: Data(hexString: "0xD1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb")!)!.eip55String,
            "0xD1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb"
        )
    }

    func testDescription() {
        let address = EthereumAddress(string: "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed")!
        XCTAssertEqual(address.description, "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed")
    }

    func testFromPrivateKey() {
        let privateKey = PrivateKey(data: Data(hexString: "4745044ccdb778fb6d2d999c561f4329deb57ee3628672d7a2954a53e20b167e")!)!
        let publicKey = privateKey.publicKey(for: .tomo)
        XCTAssertEqual(publicKey.address.description.lowercased(), "0x36d0701257ab74000588e6bdaff014583e03775b".lowercased())
    }

    func testIsValid() {
        XCTAssertFalse(EthereumAddress.isValid(string: "abc"))
        XCTAssertFalse(EthereumAddress.isValid(string: "5aaeb6053f3e94c9b9a09f33669435e7ef1beaed"))
        XCTAssertTrue(EthereumAddress.isValid(string: "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"))
    }
}
