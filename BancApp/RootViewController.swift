//
//  RootViewController.swift
//  BancApp
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import SlackTextViewController

class RootViewController: SLKTextViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Custom white background status bar
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(view)
        
        //  Configurate Slack View Controller Options
//        self.tableView!.estimatedRowHeight = viewModel.estimateRowHeight
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.backgroundColor = UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0)
        
        self.bounces = true;
        self.shakeToClearEnabled = true;
        self.keyboardPanningEnabled = true;
        self.shouldScrollToBottomAfterKeyboardShows = false;
        self.inverted = true;
        
        //  Autocompletion
//        self.autoCompletionView.estimatedRowHeight = viewModel.estimateRowHeight
        self.autoCompletionView.rowHeight = UITableViewAutomaticDimension
        
        //  Input Textfield
        self.textInputbar.autoHideRightButton = true;
//        self.textInputbar.maxCharCount = viewModel.maxChars;
        self.textInputbar.counterStyle = SLKCounterStyle.Countdown;
        self.textInputbar.counterPosition = SLKCounterPosition.Top;
        
        self.tableView!.tableFooterView = UIView();
        self.tableView!.separatorStyle = .None
        
        //  Register Cells
//        self.tableView!.registerNib(UINib(nibName: viewModel.articleCellNibName, bundle: nil), forCellReuseIdentifier: viewModel.articleCellReuseIdentifier)
//        self.autoCompletionView.registerNib(UINib(nibName: viewModel.optionsCellNibName, bundle: nil), forCellReuseIdentifier: viewModel.optionsCellReuseIdentifier)
        
        //  Register prefixes to show autocompletion
//        self.registerPrefixesForAutoCompletion(viewModel.detectAutocompletion)
        
    }
}
