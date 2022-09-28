//
//  CharacterListViewController.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!

    private var bindings = Set<AnyCancellable>()
    private var characterCollectionViewDataModel: CharacterCollectionViewDataModel?
    public var viewModel: CharacterListViewModel!
    var coordinator: Coordinator?
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
    }
    
    // MARK: States
    private func handleStates() {
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.characterCollectionViewDataModel?.updateSections(characters: self?.viewModel.characters)
            }
            .store(in: &bindings)
        
        let stateValueHandler: (CharacterListState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.visibility(condition: true)
            case .finishedLoading:
                self?.visibility(condition: false)
            case .error(let errorString):
                self?.showError(errorString)
            case .ready:
                self?.viewModel.initialize()
                self?.setUpCollectionView()
                self?.configureDataSource()
            }
        }
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    
    // MARK: Functions
    private func setUpCollectionView() {
        collectionView.register(UINib.init(nibName: Cells.characterListCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Cells.characterListCollectionViewCell.rawValue)
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func visibility(condition:Bool) {
        collectionView.isHidden = condition
        indicatorView.isHidden = !condition
    }
    
    private func configureDataSource() {
        characterCollectionViewDataModel = CharacterCollectionViewDataModel(
            collectionView: collectionView,
            output: self
        )
        characterCollectionViewDataModel?.configure()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1 / 2
        let fractionHeight: CGFloat = 1 / 3.5
        let inset: CGFloat = 5
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(fractionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: inset,
                                                        bottom: inset,
                                                        trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: CharacterCollectionViewDataModelOutput
extension CharacterListViewController:CharacterCollectionViewDataModelOutput {
    func onDidSelect(indexPath: IndexPath) {
        guard let item = self.viewModel.characters?.results?[indexPath.item] else { return }
        let vc = CharacterDetailBuilder.build(characterDetail: item)
        coordinator?.eventOccurred(with: vc)
    }
    
    func onWillDisplay(indexPath: IndexPath) {
        self.viewModel.doPagination(indexPath: indexPath)
    }
}

