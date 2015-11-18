/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import SnapKit

class LoginListViewController: UITableViewController {

    private let SearchHeaderIdentifier = "SearchHeader"

    private var loginDataSource: LoginCursorDataSource? = nil

    private let profile: Profile

    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Logins", comment: "Title for Logins List View screen")
        loginDataSource = LoginCursorDataSource(tableView: self.tableView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tableView.registerClass(SearchViewTableViewHeader.self, forHeaderFooterViewReuseIdentifier: SearchHeaderIdentifier)
        tableView.dataSource = loginDataSource
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate Overrides
extension LoginListViewController {

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let searchHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(SearchHeaderIdentifier) as! SearchViewTableViewHeader
        return searchHeader
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        return 44
    }
}

private class LoginCursorDataSource: NSObject, UITableViewDataSource {
    unowned var tableView: UITableView

    private let LoginCellIdentifier = "LoginCell"

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: LoginCellIdentifier)
    }

    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(LoginCellIdentifier, forIndexPath: indexPath)
    }
}

private class SearchViewTableViewHeader: UITableViewHeaderFooterView {

    private let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.redColor()
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(searchView)
        searchView.snp_makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}