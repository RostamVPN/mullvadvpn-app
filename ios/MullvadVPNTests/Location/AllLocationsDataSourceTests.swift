//
//  AllLocationsDataSourceTests.swift
//  MullvadVPNTests
//
//  Created by Jon Petersson on 2024-02-29.
//  Copyright © 2024 Rostam VPN AB. All rights reserved.
//

@testable import MullvadSettings
import XCTest

class AllLocationsDataSourceTests: XCTestCase {
    var allLocationNodes = [LocationNode]()
    var dataSource: AllLocationDataSource!

    override func setUp() async throws {
        setUpDataSource()
    }

    func testNodeTree() throws {
        let rootNode = RootLocationNode(children: dataSource.nodes)

        // Testing a selection.
        XCTAssertNotNil(rootNode.descendantNodeFor(codes: ["se"]))
        XCTAssertNotNil(rootNode.descendantNodeFor(codes: ["us", "dal"]))
        XCTAssertNotNil(rootNode.descendantNodeFor(codes: ["es1-wireguard"]))
        XCTAssertNotNil(rootNode.descendantNodeFor(codes: ["se2-wireguard"]))
    }

    func testSearch() throws {
        let nodes = dataSource.search(by: "got")
        let rootNode = RootLocationNode(children: nodes)

        XCTAssertTrue(rootNode.descendantNodeFor(codes: ["se", "got"])?.isHiddenFromSearch == false)
        XCTAssertTrue(rootNode.descendantNodeFor(codes: ["se", "sto"])?.isHiddenFromSearch == true)
    }

    func testSearchWithEmptyText() throws {
        let nodes = dataSource.search(by: "")
        XCTAssertEqual(nodes, dataSource.nodes)
    }

    func testNodeByLocation() throws {
        var nodeByLocation = dataSource.node(by: .country("es"))
        var nodeByCode = dataSource.nodes.first?.descendantNodeFor(codes: ["es"])
        XCTAssertEqual(nodeByLocation, nodeByCode)

        nodeByLocation = dataSource.node(by: .city("es", "mad"))
        nodeByCode = dataSource.nodes.first?.descendantNodeFor(codes: ["es", "mad"])
        XCTAssertEqual(nodeByLocation, nodeByCode)

        nodeByLocation = dataSource.node(by: .hostname("es", "mad", "es1-wireguard"))
        nodeByCode = dataSource.nodes.first?.descendantNodeFor(codes: ["es1-wireguard"])
        XCTAssertEqual(nodeByLocation, nodeByCode)
    }
}

extension AllLocationsDataSourceTests {
    private func setUpDataSource() {
        let response = ServerRelaysResponseStubs.sampleRelays
        let relays = response.wireguard.relays

        dataSource = AllLocationDataSource()
        dataSource.reload(response, relays: relays)
    }
}
