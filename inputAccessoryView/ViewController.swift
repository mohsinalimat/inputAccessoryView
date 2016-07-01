//
//  ViewController.swift
//  inputAccessoryView
//
//  Created by GabrielMassana on 01/07/2016.
//  Copyright © 2016 GabrielMassana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// A table View to show the messages entered through the textView
    lazy var tableView: UITableView = {
        
        let tableView: UITableView = UITableView(frame: UIScreen.mainScreen().bounds,
                                                 style: UITableViewStyle.Plain)
        
        tableView.dataSource = self

        // Important to allow pan down while dismissing the keyboard.
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        
        return tableView
    }()
    
    /// The UIView sunview with a UITextView to enter text.
    /// This view id going to be the inputAccessoryView
    lazy var answerComposer: AnswerComposer = {
       
        let answerComposer = AnswerComposer(frame: CGRectMake(0.0,
            CGRectGetHeight(UIScreen.mainScreen().bounds) - 60.0,
            CGRectGetWidth(UIScreen.mainScreen().bounds),
            60.0))
        
        return answerComposer
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.addSubview(tableView)
        
        // We can not add the AnswerComposer as subview of self.view with view.addSubview(answerComposer) because we will have a crash like:
        
        // 'UIViewControllerHierarchyInconsistency', reason: 'child view controller:<UICompatibilityInputViewController: 0x7fec9c817210> should have parent view controller:<inputAccessoryView.ViewController: 0x7fec9a4635b0> but requested parent is:<UIInputWindowController: 0x7fec9c05b000>'
        
        // But we can add the AnswerComposer as the Window subview
        UIApplication.sharedApplication().keyWindow?.addSubview(answerComposer)
        
        // No problem now to set the inputAccessoryView
        answerComposer.textView.inputAccessoryView = answerComposer
        
        registerCells()
    }
    
    func registerCells() {
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }
}

extension ViewController: UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self), forIndexPath: indexPath)
        
        cell.textLabel?.text = "textLabel"
        
        return cell
    }
}
