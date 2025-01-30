//
//  HomeViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var homeTableView: UITableView!
    @IBOutlet private weak var homeCollectionView: UICollectionView! {
        didSet {
            homeCollectionView.semanticContentAttribute = L102Language.isRTL ? .forceRightToLeft : .forceLeftToRight
        }
    }
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.handleHorizontalDataArray()
    }
    
    private func setupViews() {
        setCollectionView()
        setTableView()
        navigationItem.title = "Home".localize
        bindUI()
    }
}

// MARK: Setup UITableView Delegate and DataSource
extension HomeViewController: TableViewConfig {
    
    func setTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerCellNib(cellClass: HomeTableViewCell.self)
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.verticalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(with: HomeTableViewCell.self, for: indexPath)
        cell.configureCell(data: viewModel.verticalData[indexPath.row])
        return cell
    }
}

// MARK: Setup UICollection Delegate and DataSource
extension HomeViewController: CollectionViewConfig {
    
    func setCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.registerCell(cellClass: HomeCollectionViewCell.self)
        guard let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 20, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.horizontalDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(with: HomeCollectionViewCell.self, for: indexPath)
        cell.configureCell(data: viewModel.horizontalDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedHorizontalDataArray(index: indexPath.row)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 40)
    }
}

// MARK: UI BIND
private extension HomeViewController {
    
    func bindUI() {
        bindReloadIsArabicHomeCollectionViewLogin()
        bindIsScrollHorizontalCollectionView()
    }
    
    func bindReloadIsArabicHomeCollectionViewLogin() {
        viewModel.$reloadIsArabicHomeCollectionView.sink { [weak self] isArabic in
            guard let self else { return }
            homeCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                if isArabic ?? false {
                    self.homeCollectionView.scrollToItem(at: IndexPath(row: (self.viewModel.horizontalDataArray.count - 1), section: 0), at: .centeredHorizontally, animated: true)
                } else {
                    self.homeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
        }.store(in: &cancellable)
    }
    
    func bindIsScrollHorizontalCollectionView() {
        viewModel.$isScrollHorizontalCollectionView.sink { [weak self] index in
            guard let self, index != nil else { return }
            homeCollectionView.reloadData()
            homeCollectionView.scrollToItem(at: IndexPath(row: index ?? 0, section: 0), at: .centeredHorizontally, animated: true)
        }.store(in: &cancellable)
    }
}
