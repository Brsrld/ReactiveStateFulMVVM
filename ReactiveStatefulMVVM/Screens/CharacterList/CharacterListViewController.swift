//
//  CharacterListViewController.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {
    
    public var viewModel: CharacterListViewModel!
    private var bindings = Set<AnyCancellable>()
    //private var feedCollectionDataManager: FeedCollectionDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLaunches()
        setUpBinding()
    }
    
    private func setUpBinding() {
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                print(self?.viewModel.characters)
            }
            .store(in: &bindings)
        
        let stateValueHandler: (CharacterListState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                print("Loading")
            case .finishedLoading:
                print("finishedLoading")
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
}
