//
//  SearchResultsViewController.swift
//  v3
//
//  Created by Jun on 2023-02-09.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    public var results: [SearchResult] = [SearchResult]()
    
    public let ListPropertyTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PropertyListViewTableViewCell.self, forCellReuseIdentifier: PropertyListViewTableViewCell.identifier)
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyListViewTableViewCell.identifier, for: indexPath) as? PropertyListViewTableViewCell else {
            return UITableViewCell()
        }
        let result = results[indexPath.row]
        cell.config(with: ListingViewModel(priceLabel: "", addressLable: result.Address_EN, ListImageURL: "house"))
        return cell
    }

}


