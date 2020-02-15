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

final class JobsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentioView: Segmentio!

    private let disposeBag = DisposeBag()
    private var jobList = [JobModel]()
    var viewModel: JobsListDataSource = JobsListViewModel()
    var storedOffsets = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupUI()
        self.setupSegmentioView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupUI() {
        self.navigationController?.configureNavigationBar()
        self.tableView.hideEmptyCells()
        self.view.backgroundColor = .viewBackgroundColor
        self.tableView.backgroundColor = .tableViewBackgroundColor
    }

    private func setupSegmentioView() {
        let segmentioContent =  viewModel.segmentTitleList.compactMap { title -> SegmentioItem in
            return SegmentioItem(title: title, image: nil)
        }

        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: .onlyLabel,
            segmentioContent: segmentioContent
        )
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.valueDidChange = { [weak self] segmentio, segmentIndex in
            DDLogInfo("Selected item: \(segmentIndex)")
            guard let segmentModel = SegmentModel(rawValue: segmentIndex) else {
                assertionFailure("SegmentModel does not exist")
                return
            }
            self?.viewModel.updateList(withSegmentModel: segmentModel)
        }
    }

    private func setupViewModel() {
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
        viewModel.viewDidLoad()
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
        cell.configure(self.jobList[indexPath.row])
        cell.descriptionLabel.text = viewModel.businessesStatus(data.connectedBusinesses)
        cell.moreButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.presentPopMenuView(withSourceView: cell.moreButton)
        }).disposed(by: cell.disposeBagCell)
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        cell.collectionViewContentOffsett = storedOffsets[indexPath.row] ?? 0

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    private func presentPopMenuView(withSourceView sourceView: AnyObject) {
        let popMenuBuilder = PopMenuBuilder()
        let popMenuViewController = popMenuBuilder.buildPopMenuClose(sourceView)
        popMenuViewController.didDismiss = { selected in
            DDLogInfo("Menu dismissed: \(selected ? "selected item" : "no selection")")
        }
        present(popMenuViewController, animated: true, completion: nil)
    }
}

extension JobsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobList[collectionView.tag].connectedBusinesses?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BusinessCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = jobList[collectionView.tag].connectedBusinesses?[indexPath.item]
        cell.configure(data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DDLogInfo("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
