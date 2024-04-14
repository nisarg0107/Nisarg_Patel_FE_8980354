//
//  Nisarg_Patel_FE_8980354UITestsLaunchTests.swift
//  Nisarg_Patel_FE_8980354UITests
//
//  Created by user238292 on 4/13/24.
//

import XCTest

final class Nisarg_Patel_FE_8980354UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
