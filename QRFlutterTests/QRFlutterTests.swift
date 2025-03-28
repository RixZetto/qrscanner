//
//  QRFlutterTests.swift
//  QRFlutterTests
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import Testing
@testable import QRFlutter

struct QRFlutterTests {

    @Test func havingQRCodeInsertToRepository() async throws {
        let repository: QRRepository = await QRRepositoryMockData()
        await repository.saveQRCode("abcdef")
        let total = await repository.totalQRCodes()
        assert(total == 3)
    }
    
    @Test func havingQRCodeRetrieveFromRepository() async throws {
        let repository: QRRepository = await QRRepositoryMockData()
        let total = await repository.totalQRCodes()
        assert(total == 2)
        let codes = await repository.fetchQRCodes()
        assert(codes[0].content == "1234567890")
        assert(codes[1].content == "1234567891")
    }

}
