//
//  JobsListViewController.swift
//  OpenJobs
//
//  Created by Nischal Hada on 26/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Segmentio
import CocoaLumberjack
import PopMenu

class JobsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentioView: Segmentio!

    private let disposeBag = DisposeBag()
    private var jobList = [JobModel]()
    var viewModel: JobsListDataSource = JobsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupUI()
        self.setupSegmentioView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setupUI() {
        self.navigationController?.configureNavigationBar()
        self.tableView.hideEmptyCells()
        self.view.backgroundColor = .viewBackgroundColor
        self.tableView.backgroundColor = .tableViewBackgroundColor
    }

    func setupSegmentioView() {
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: .onlyLabel
        )
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            DDLogInfo("Selected item: \(segmentIndex)")
            guard let segmentModel = SegmentModel(rawValue: segmentIndex) else {
                assertionFailure("SegmentModel does not exist")
                return
            }
            self.viewModel.updateList(withSegmentModel: segmentModel)
        }
    }

    func setupViewModel() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.jobsList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.jobList = list
                self?.tableView.reloadData()
                if !list.isEmpty {
                    self?.tableView.scrollToTopRow()
                }
                }, onError: { error in
                    self.showAlertView(withTitle: "error", andMessage: error.localizedDescription)
            })
            .disposed(by: disposeBag)
        viewModel.getJobsFromLocalDb()
        viewModel.getJobsList()
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardTableViewCell
        let data = self.jobList[indexPath.row]
        cell.newsInfo = self.jobList[indexPath.row]
        cell.descriptionLabel.text = viewModel.businessesStatus(data.connectedBusinesses)
        cell.moreButton.rx.tap.subscribe(onNext: { _ in
            self.presentPopMenuView(withSourceView: cell.moreButton)
        }).disposed(by: disposeBag)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func presentPopMenuView(withSourceView sourceView: AnyObject) {
        let popMenuBuilder = PopMenuBuilder()
        let popMenuViewController = popMenuBuilder.buildPopMenuClose(sourceView)
        popMenuViewController.didDismiss = { selected in
            DDLogInfo("Menu dismissed: \(selected ? "selected item" : "no selection")")
        }
        present(popMenuViewController, animated: true, completion: nil)
    }
}
