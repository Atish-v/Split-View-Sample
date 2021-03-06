//
//  CourseListViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 05/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate:
class {
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) -> Void
}

class CourseListViewController: NSViewController {
    
    weak var delegate: CourseListViewControllerDelegate? = nil
    
    dynamic var courses: [Course] = []
    
    let fetcher = ScheduleFetcher()
    
    @IBOutlet var arrayController: NSArrayController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        fetcher.fetchCoursesUsingCompletionHandler(completionHandler: {(result) in
            switch result {
            case .Success(let courses):
                print("Got courses : \(courses)")
                self.courses = courses
            case .Failure(let error):
                print("Got error : \(error)")
                NSAlert (error:error).runModal()
                self.courses = []
            }})
    }
    
    @IBAction func selectCourse(sender: AnyObject) {
        let selectedCourse = arrayController.selectedObjects.first as! Course?
        delegate?.courseListViewController(viewController: self, selectedCourse: selectedCourse)
    }
    
}
