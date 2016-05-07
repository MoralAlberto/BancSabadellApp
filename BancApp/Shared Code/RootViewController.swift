//
//  RootViewController.swift
//  BancApp
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import SlackTextViewController

class RootViewController: SLKTextViewController {
    
    var viewModel = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        //  Custom white background status bar
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(view)
        
        //  Configurate Slack View Controller Options
        self.tableView!.estimatedRowHeight = viewModel.estimateRowHeight
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.backgroundColor = UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0)
        
        self.bounces = true;
        self.shakeToClearEnabled = true;
        self.keyboardPanningEnabled = true;
        self.shouldScrollToBottomAfterKeyboardShows = false;
        self.inverted = true;
        
        //  Autocompletion
        self.autoCompletionView.estimatedRowHeight = viewModel.estimateRowHeight
        self.autoCompletionView.rowHeight = UITableViewAutomaticDimension
        
        //  Input Textfield
        self.textInputbar.autoHideRightButton = true;
        self.textInputbar.maxCharCount = viewModel.maxChars;
        self.textInputbar.counterStyle = SLKCounterStyle.Countdown;
        self.textInputbar.counterPosition = SLKCounterPosition.Top;
        
        self.tableView!.tableFooterView = UIView();
        self.tableView!.separatorStyle = .None
        
        //  Register Cells: BancSabacellCell and OptionCell
        self.tableView!.registerNib(UINib(nibName: viewModel.bancSabadellCellNibName, bundle: nil), forCellReuseIdentifier: viewModel.bancSabadellCellReuseIdentifier)
        
        self.autoCompletionView.registerNib(UINib(nibName: viewModel.optionsCellNibName, bundle: nil), forCellReuseIdentifier: viewModel.optionsCellReuseIdentifier)
        
        //  Register prefixes to show autocompletion
        self.registerPrefixesForAutoCompletion(viewModel.detectAutocompletion)
        
        //  API CALL
        self.viewModel.getAccounts()
    }
    

    //MARK: TableView DataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  Show me the messages! or show me the autocompletion option
        return (tableView.isEqual(self.tableView)) ? viewModel.messages.count : viewModel.searchResult.count
    }
    
    //  Select on cell type or another, depending if the user is type some autocompletion keyword like: '#', '@', etc in our case '#'
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return (tableView.isEqual(self.tableView)) ? self.messageCellForRowAtIndexPath(indexPath) : self.autoCompletionCellForRowAtIndexPath(indexPath)
    }
    
    func messageCellForRowAtIndexPath(indexPath: NSIndexPath) -> BancSabadellCell {
        let cell = self.tableView!.dequeueReusableCellWithIdentifier(viewModel.bancSabadellCellReuseIdentifier, forIndexPath:indexPath) as? BancSabadellCell
        
        let text = viewModel.messages[indexPath.row]
        cell?.viewModel.configureWithArticle(text, atIndexPath: indexPath)
        cell?.transform = self.tableView!.transform;
        
        return cell!
    }
    

    //MARK: TableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView.isEqual(self.autoCompletionView)) {
            
            let optionName = viewModel.detectOptionSelected(self.foundPrefix!, range: self.foundPrefixRange, atIndexPath: indexPath)
            self.acceptAutoCompletionWithString(optionName, keepPrefix: true)
        }
    }

    override func heightForAutoCompletionView() -> CGFloat {
        return 60.0 * CGFloat(viewModel.searchResult.count)
    }
    
    //MARK: Override Slack Methods
    override func didPressRightButton(sender: AnyObject!) {
        
        self.textView.refreshFirstResponder();
        
        let message = BancSabadellModel()
//        message.title = self.textView.text
//        message.summary = "NOOO"
//        message.sourceURL = "www.google.com"
        
        
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        let scrollPosition = self.inverted ? UITableViewScrollPosition.Bottom : UITableViewScrollPosition.Top;
        let rowAnimation = self.inverted ? UITableViewRowAnimation.Bottom : UITableViewRowAnimation.Top
        
        self.tableView!.beginUpdates()
        
        self.viewModel.messages.insert(message, atIndex: 0)
        
        self.tableView!.insertRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
        self.tableView!.endUpdates()
        
        self.tableView!.scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: true)
        
        self.tableView!.reloadRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
        
        super.didPressRightButton(sender)
    }
    
    override class func tableViewStyleForCoder(decoder: NSCoder) -> UITableViewStyle {
        return UITableViewStyle.Plain;
    }
    
    
    override func textDidUpdate(animated: Bool) {
        super.textDidUpdate(animated)
    }
    
    
    override func didChangeAutoCompletionPrefix(prefix: String, andWord word: String) {
        viewModel.arrayWithCoincidences(prefix, word: word)
        self.showAutoCompletionView(viewModel.showAutocompletation())
    }
    
    
    func autoCompletionCellForRowAtIndexPath(indexPath: NSIndexPath) -> OptionCell {
        let cell = self.autoCompletionView.dequeueReusableCellWithIdentifier(viewModel.optionsCellReuseIdentifier, forIndexPath:  indexPath) as? OptionCell
        
        let text = viewModel.searchResult[indexPath.row];
        cell?.viewModel.configureWithOption((text as? String)!, atIndexPath: indexPath)
        
        
        return cell!
    }
    
}

extension RootViewController: RootViewModelDelegate {
    
    func updateView() {
        self.tableView?.reloadData()
    }
}