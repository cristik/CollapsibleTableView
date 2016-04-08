//
//  SettingViewModelTests.swift
//  CollapsibleTableView
//
//  Created by Andrei Balasanu on 4/8/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import XCTest
@testable import CollapsibleTableView

class SettingViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testModelPropertyIsSetUponInitialization() {
        let model = Setting(name: "Appearance")
        let viewModel = SettingViewModel(setting: model)

        XCTAssertEqual(viewModel.setting, model)
    }

    func testTitlePropertyIsSetUponInitialization() {
        let model = Setting(name: "Appearance")
        let viewModel = SettingViewModel(setting: model)

        XCTAssertEqual(viewModel.title, model.name)
    }

    func testImagePropertyIsSetUponInitialization() {
        let model = Setting(name: "Appearance")
        let viewModel = SettingViewModel(setting: model)

        var image: UIImage? = nil
        if let imageName = model.imageName {
            image = UIImage(named: imageName)
        }

        XCTAssertEqual(viewModel.image, image)
    }

    func testIndentationLevelIsSetUponInitialization() {
        let model = Setting(name: "Appearance")
        let viewModelIntrinsicIndentationLevel = SettingViewModel(setting: model)
        let viewModelExplicitIndentationLevel = SettingViewModel(setting: model, indentationLevel: 3)

        XCTAssertEqual(viewModelIntrinsicIndentationLevel.indentationLevel, 0)
        XCTAssertEqual(viewModelExplicitIndentationLevel.indentationLevel, 3)
    }

    func testSubsettingsInitialization() {
        let model = Setting(name: "Account", subsettings: [
                        Setting(name: "Profile"),
                        Setting(name: "Password"),
                        Setting(name: "Other")])
        let viewModel = SettingViewModel(setting: model)

        XCTAssertEqual(model.subsettings, viewModel.subsettings.map { $0.setting })

        // IndentationLevel should be automattically set
        let filteredSubsettings = viewModel.subsettings.filter { $0.indentationLevel == 1 }
        XCTAssertEqual(viewModel.subsettings, filteredSubsettings)
    }
}
