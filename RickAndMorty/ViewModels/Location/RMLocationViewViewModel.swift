//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 18.09.2023.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewViewModel {
    
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public var isLoadingMoreLocations: Bool = false
    
    init() {
        
    }
    
    public func fetchLocations() {
        RMService.shared.execute(
            .listLocationsRequests,
            expecting: RMGetAllLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private var hasMoreResults: Bool = false
    
    public func location(at index: Int) -> RMLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        
        return self.locations[index]
    }
    
    public func fetchAdditionalLocations() {
        if isLoadingMoreLocations {
            return
        }
        
        guard let nextURLstring = apiInfo?.next,
              let url = URL(string: nextURLstring) else {
            return
        }
        
        isLoadingMoreLocations = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreLocations = true
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({ location in
                    return RMLocationTableViewCellViewModel(location: location)
                }))
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreLocations = false
                }
            case .failure(let error):
                print(String(describing: error))
                strongSelf.isLoadingMoreLocations = false
            }
        }
    }
}
