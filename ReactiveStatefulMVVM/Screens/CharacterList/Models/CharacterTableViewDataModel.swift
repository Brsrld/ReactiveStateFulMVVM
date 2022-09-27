//
//  CharacterTableViewDataModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource< CharacterListViewModel.Section, Characters>
typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterListViewModel.Section, Characters>

protocol CharacterCollectionViewDataModelOutput {
    func onDidSelect(indexPath: IndexPath)
    func onWillDisplay(indexPath: IndexPath)
}

final class CharacterCollectionViewDataModel: NSObject {
    
    // MARK: Properties
    private let collectionView: UICollectionView
    private var dataSource: DataSource?
    
    var output: CharacterCollectionViewDataModelOutput?
    
    // MARK: Init
    init(collectionView: UICollectionView,
         output: CharacterCollectionViewDataModelOutput) {
        self.collectionView = collectionView
        self.output = output
        super.init()
    }
    
    // MARK: Public Func
    func configure() {
        configureDataSource()
    }
    
    func updateSections(characters: Characters?) {
        guard let characters = characters else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.character])
        snapshot.appendItems([characters])
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Private Func
    private func configureDataSource() {
        collectionView.delegate = self
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CharacterListCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? CharacterListCollectionViewCell
                guard let item = character.results?[indexPath.row] else { return UICollectionViewCell()}
                cell?.configureCell(viewModel: CharacterListCellViewModel(character: item))
                return cell
            })
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterCollectionViewDataModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.output?.onWillDisplay(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output?.onDidSelect(indexPath: indexPath)
    }
}
