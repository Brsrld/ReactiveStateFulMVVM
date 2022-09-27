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
    
    public var viewModel: CharacterListViewModel!
    private var bindings = Set<AnyCancellable>()
    private var characterCollectionViewDataModel: CharacterCollectionViewDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLaunches()
        setUpCollectionView()
        configureDataSource()
        setUpBinding()
    }
    
    private func setUpCollectionView() {
        collectionView.register(CharacterListCollectionViewCell.self,
                                            forCellWithReuseIdentifier: CharacterListCollectionViewCell.reuseIdentifier)
    }
    
    private func setUpBinding() {
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.characterCollectionViewDataModel?.updateSections(characters: self?.viewModel.characters)
            }
            .store(in: &bindings)
        
        let stateValueHandler: (CharacterListState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                print("Loading")
            case .finishedLoading:
                self?.collectionView.backgroundColor = .red
            case .error(let errorString):
                print("finishedLoading")
            case .ready:
                print("ready")
            }
        }
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    
    private func configureDataSource() {
        characterCollectionViewDataModel = CharacterCollectionViewDataModel(
            collectionView: collectionView,
            output: self.viewModel
        )
        characterCollectionViewDataModel?.configure()
    }
}

