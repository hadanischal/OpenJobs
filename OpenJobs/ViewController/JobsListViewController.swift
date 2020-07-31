//
//  JobsListViewController.swift
//  OpenJobs
//
//  Created by Nischal Hada on 26/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import CocoaLumberjack
import PopMenu
import RxCocoa
import RxSwift
import Segmentio
import UIKit

final class JobsListViewController: UIViewController, BaseViewProtocol {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentioView: Segmentio!

    private let disposeBag = DisposeBag()
    var viewModel: JobsListDataSource = JobsListViewModel()
    var storedOffsets = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        configureTableView()
        setupSegmentioView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupUI() {
        navigationController?.configureNavigationBar()
        view.backgroundColor = .viewBackgroundColor
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    private func setupViewModel() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)

        viewModel.updateInfo
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.errorResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: error.localizedDescription)
            }).disposed(by: disposeBag)

        viewModel.isLoading.bind(to: isAnimating).disposed(by: disposeBag)

        viewModel.viewDidLoad()
    }

    private func setupSegmentioView() {
        let segmentioContent = viewModel.segmentTitleList.compactMap { title -> SegmentioItem in
            SegmentioItem(title: title, image: nil)
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

    private func presentPopMenuView(withSourceView sourceView: AnyObject) {
        let popMenuBuilder = PopMenuBuilder()
        let popMenuViewController = popMenuBuilder.buildPopMenuClose(sourceView)
        popMenuViewController.didDismiss = { selected in
            DDLogInfo("Menu dismissed: \(selected ? "selected item" : "no selection")")
        }
        present(popMenuViewController, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension JobsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DashboardTableViewCell
        let data = viewModel.info(forIndex: indexPath.row)
        cell.configure(data)

        cell.moreButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.presentPopMenuView(withSourceView: cell.moreButton)
        }).disposed(by: cell.disposeBagCell)

        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        cell.collectionViewContentOffsett = storedOffsets[indexPath.row] ?? 0

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension JobsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.connectedBusinessesCount(index: collectionView.tag)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BusinessCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.info(forIndex: collectionView.tag).connectedBusinesses[indexPath.item]
        cell.configure(data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        DDLogInfo("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
