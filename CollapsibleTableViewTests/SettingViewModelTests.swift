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

    func testSubsettings() {
        let model = Setting(name: "Account", subsettings: [
                        Setting(name: "Profile"),
                        Setting(name: "Password"),
                        Setting(name: "Other")])
        let viewModel = SettingViewModel(setting: model)

        viewModel.expanded = false
        XCTAssertEqual(viewModel.subsettings.count, 0, "Subsettings count should be 0 when not expanded")

        viewModel.expanded = true
        XCTAssertEqual(model.subsettings, viewModel.subsettings.map { $0.setting }, "Subsettings should be initialized correctly when expanded")

        // IndentationLevel should be automattically set
        let filteredSubsettings = viewModel.subsettings.filter { $0.indentationLevel == 1 }
        XCTAssertEqual(viewModel.subsettings, filteredSubsettings, "Subsetting indentationLevel should be equal to parent setting indentationLevel+1")
    }

    func testFlatSubsettings() {
        let model = Setting(name: "Account", subsettings: [
            Setting(name: "Profile"),
            Setting(name: "Password"),
            Setting(name: "Other")])
        let viewModel = SettingViewModel(setting: model)

        viewModel.expanded = false
        XCTAssertEqual(viewModel.flatSettings(), [viewModel], "When not expanded, flatSubsettings should return an array that contains only the parent setting")

        viewModel.expanded = true
        XCTAssertEqual(viewModel.flatSettings(), [viewModel] + viewModel.subsettings, "When expanded, flatSubsettings should return an array containing the setting and the subsettings")
    }

    func testToggleExpansionStatus() {
        let model = Setting(name: "Account", subsettings: [
            Setting(name: "Profile"),
            Setting(name: "Password"),
            Setting(name: "Other")])
        let viewModel = SettingViewModel(setting: model)

        viewModel.toggleExpansionStatus()
        XCTAssertTrue(viewModel.expanded, "Toggling expansion status, should set the expanded property to true")

        viewModel.toggleExpansionStatus()
        XCTAssertFalse(viewModel.expanded, "Toggling expansion status, should set the expanded property to false")
    }
}
