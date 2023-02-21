//
//  SearchResultsViewController.swift
//  v3
//
//  Created by Jun on 2023-02-09.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func SearchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var results: [SearchResult] = [SearchResult]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let ListPropertyTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SearchPropertyListViewTableViewCell.self, forCellReuseIdentifier: SearchPropertyListViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(ListPropertyTableView)
        
        ListPropertyTableViewDelegate()
        
        searchAPICall()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ListPropertyTableView.frame = view.bounds
    }
    
    func ListPropertyTableViewDelegate() {
        ListPropertyTableView.delegate = self
        ListPropertyTableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ListPropertyTableView.frame = view.bounds
    }
    
    
    

    
    func searchAPICall(){
        APICaller.shared.getSearchList(for: "montreal") { [weak self] result in
            switch result {
            case.success(let results):
                self?.results = results
                DispatchQueue.main.async {
                    self?.ListPropertyTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPropertyListViewTableViewCell.identifier, for: indexPath) as? SearchPropertyListViewTableViewCell else {
            return UITableViewCell()
        }
        let result = results[indexPath.row]
        cell.config(with: ListingViewModel(priceLabel: "", addressLable: result.Address_EN, ListImageURL: ""))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let searchResult = results[indexPath.row]
        
        let mls = searchResult.ReferenceNumber
        print(mls)
        
        APICaller.shared.SearchByMLS(for: mls) { [weak self] result in
            switch result {
            case .success(let MLSResult):
                self?.delegate?.SearchResultsViewControllerDidTapItem(TitlePreviewViewModel(favouriteIcon: "heart",
                                                                                            shareIcon: "heart",
                                                                                            propertyImage: (MLSResult[0].Property?.Photo![0].HighResPath)!,
                                                                                            price: (MLSResult[0].Property?.Price ?? ""),
                                                                                            address: (MLSResult[0].Property?.Address?.AddressText ?? ""),
                                                                                            bedroomNum: (MLSResult[0].Building?.Bedrooms ?? "0"),
                                                                                            propertyInfoDetailes: (MLSResult[0].PublicRemarks)!,
                                                                                            MlsNumber: (MLSResult[0].MlsNumber)!,
                                                                                            bathroom: (MLSResult[0].Building?.BathroomTotal ?? "0"),
                                                                                            agentImage: MLSResult[0].Individual?[0].PhotoHighRes ?? "",
                                                                                            agentName: MLSResult[0].Individual?[0].Name ?? "",
                                                                                            agentPhone: MLSResult[0].Individual?[0].Phones?[0].PhoneNumber ?? "",
                                                                                            agentCompanyLogo: MLSResult[0].Individual?[0].Organization.Logo ?? "",
                                                                                            agentCompany: MLSResult[0].Individual?[0].Organization.Name ?? ""
                                                                                                      )
                                                                                          )
            case .failure(let error):
                print("no propertyMls + @ FavoriteViewController 142")
                print(error.localizedDescription)
            }
        }
    }
}



