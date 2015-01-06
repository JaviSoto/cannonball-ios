//
// Copyright (C) 2014 Twitter, Inc. and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//         http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

class TweetListViewController: UITableViewController {

    var tweets: [TWTRTweet] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    var prototypeCell: UITableViewCell!

    let tweetTableCellReuseIdentifier = "TweetCell"

    var isLoadingTweets = false

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the table view.
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = false

        // Create a single prototype cell for height calculations.
        self.prototypeCell = UITableViewCell(style: .Default, reuseIdentifier: tweetTableCellReuseIdentifier)

        // Register the identifier for TWTRTweetTableViewCell.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: tweetTableCellReuseIdentifier)

        // Setup the refresh control.
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: Selector("refreshInvoked"), forControlEvents: UIControlEvents.ValueChanged)

        // Customize the navigation bar.
        self.navigationController?.navigationBar.topItem?.title = ""

        // Add a table header.
        let headerHeight: CGFloat = 20
        let contentHeight = self.view.frame.size.height - headerHeight
        let navHeight = self.navigationController?.navigationBar.frame.height
        let navYOrigin = self.navigationController?.navigationBar.frame.origin.y
        self.tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, headerHeight))

        // Add an initial offset to the table view to show the animated refresh control.
        let refreshControlOffset = self.refreshControl?.frame.size.height
        self.tableView.frame.origin.y += refreshControlOffset!
        self.refreshControl?.beginRefreshing()

        // Trigger an initial Tweet load.
        loadTweets()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Make sure the navigation bar is not translucent when scrolling the table view.
        self.navigationController?.navigationBar.translucent = false
    }

    func loadTweets() {
        // Do not trigger another request if one is already in progress.
        if self.isLoadingTweets {
            return
        }
        self.isLoadingTweets = true

        // TODO: Request tweets

        // End the refresh indicator.
        self.refreshControl?.endRefreshing()

        // Update the boolean since we are no longer loading Tweets.
        self.isLoadingTweets = false
    }

    func refreshInvoked() {
        // Trigger a load for the most recent Tweets.
        loadTweets()
    }

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of Tweets.
        return self.tweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve the Tweet cell.
        let cell = tableView.dequeueReusableCellWithIdentifier(tweetTableCellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.estimatedRowHeight
    }

}
