//
//  CharacterListViewController.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    
    public var viewModel: CharacterListViewModel!
    private var bindings = Set<AnyCancellable>()
    private var characterCollectionViewDataModel: CharacterCollectionViewDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib.init(nibName: "CharacterListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterListCollectionViewCell")
        collectionView.collectionViewLayout = createLayout()
    }
    
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
                self?.viewModel.getCharacters()
                self?.setUpCollectionView()
                self?.configureDataSource()
            }
        }
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    private func visibility(condition:Bool) {
        collectionView.isHidden = condition
        indicatorView.isHidden = !condition
    }
    
    private func configureDataSource() {
        characterCollectionViewDataModel = CharacterCollectionViewDataModel(
            collectionView: collectionView,
            output: self.viewModel
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

