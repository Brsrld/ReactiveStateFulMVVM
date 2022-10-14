//
//  CharacterTableViewDataModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource< CharacterListViewModel.Section, Result>
typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterListViewModel.Section, Result>

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
    func configure(service:ServiceGeneratorProtocol) {
        configureDataSource(service:service)
    }
    
    func updateSections(characters: Characters?) {
        guard let characters = characters?.results else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.character])
        snapshot.appendItems(characters)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Private Func
    private func configureDataSource(service:ServiceGeneratorProtocol) {
        collectionView.delegate = self
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CharacterListCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? CharacterListCollectionViewCell
                cell?.configureCell(viewModel: CharacterListCellViewModel(characterDetail: character, service:service))
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
