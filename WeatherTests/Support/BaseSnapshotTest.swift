//
//  BaseSnapshotTest.swift
//  WeatherTests
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import iOSSnapshotTestCase
import UIKit

class BaseSnapShotTest: FBSnapshotTestCase {

    var window: UIWindow!
    var baseNavigation: UINavigationController!
    var rootVC: UIViewController!
    private var currentVC: UIViewController!

    override func setUp() {
        super.setUp()
        rootVC = UIViewController()
        baseNavigation = UINavigationController(rootViewController: rootVC)
        baseNavigation.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = baseNavigation
        window.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        rootVC?.dismiss(animated: false, completion: nil)
        baseNavigation = nil
        rootVC = nil
        window = nil
        currentVC = nil
    }

    func setupAndTakeSnapshots(viewController: UIViewController,
                               needsWait: Bool = true,
                               pixelTolerance: CGFloat = .zero,
                               overallTolerance: CGFloat = .zero,
                               file: StaticString = #file,
                               line: UInt = #line) {
        setupViewForSnapshot(viewController: viewController, file: file, line: line)
        takeSnapshotsForAllScreens(needsWait: needsWait,
                                   pixelTolerance: pixelTolerance,
                                   overallTolerance: overallTolerance,
                                   file: file,
                                   line: line)
    }

    func setupViewForSnapshot(viewController: UIViewController,
                              file: StaticString = #file,
                              line: UInt = #line) {
        currentVC = viewController
        let expect = expectation(description: "finish loading view")
        viewController.modalPresentationStyle = .fullScreen
        rootVC.present(viewController, animated: false, completion: {
            expect.fulfill()
        })
        wait(for: [expect], timeout: 5.0)
    }

    func takeSnapshotsForAllScreens(needsWait: Bool = true,
                                    pixelTolerance: CGFloat = 0.01,
                                    overallTolerance: CGFloat = 0.01,
                                    file: StaticString = #file,
                                    line: UInt = #line) {
        if needsWait {
            waitBeforeContinue(time: 2.0)
        }
        ScreenSize.allCases.forEach { screenSize in
            window.bounds = screenSize.value
            currentVC.view.layoutIfNeeded()
            window.layoutIfNeeded()
            FBSnapshotVerifyView(window,
                                 identifier: screenSize.rawValue,
                                 perPixelTolerance: pixelTolerance,
                                 overallTolerance: overallTolerance,
                                 file: file,
                                 line: line)
        }
    }
    
    func waitBeforeContinue(time: TimeInterval = 5) {
        let expect = expectation(description: "wait before continue")
        _ = XCTWaiter.wait(for: [expect], timeout: time)
    }

}
