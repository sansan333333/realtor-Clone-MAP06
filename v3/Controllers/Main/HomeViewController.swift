//
//  HomeViewController.swift
//  v3
//
//  Created by Jun on 2023-02-07.
//

import UIKit


class HomeViewController: UIViewController {
    
    var results: [Result] = [Result]()
    var page = 1
    var hasMorePropertys = true
    
    private let ListPropertyTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PropertyListViewTableViewCell.self, forCellReuseIdentifier: PropertyListViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(ListPropertyTableView)
        
        ListPropertyTableViewDelegate()
        
        let headerView = MapUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 380))
        ListPropertyTableView.tableHeaderView = headerView
        
        configNavBar()
        
        homeVCListingAPICall(page: page)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ListPropertyTableView.frame = view.bounds
    }
    
    //tabelView delegate & dataSource
    func ListPropertyTableViewDelegate() {
        ListPropertyTableView.delegate = self
        ListPropertyTableView.dataSource = self
    }
    
    //top navbar on tableView
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil)
        //.label system color (black and white)
        navigationController?.navigationBar.tintColor = .label
    }

    
    func homeVCListingAPICall(page: Int) {
        APICaller.shared.getHomePageList(for: page) { [weak self] result in
            switch result {
            case .success(let results):
                
//                no add with recall APICaller
//                self?.results = results
                
                if results.count < 10 { self?.hasMorePropertys = false }
                self?.results.append(contentsOf: results)
                DispatchQueue.main.async {
                    self?.ListPropertyTableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyListViewTableViewCell.identifier, for: indexPath) as? PropertyListViewTableViewCell else {
            return UITableViewCell()
        }
        
        let result = results[indexPath.row]
        cell.config(with: ListingViewModel(priceLabel: (result.Property?.Price) ?? "", addressLable: (result.Property?.Address?.AddressText) ?? "", ListImageURL: (result.Property?.Photo?[0].HighResPath) ?? "house"))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let results = results[indexPath.row]
        guard let searchByMLS = results.MlsNumber else { return }
        
        APICaller.shared.SearchByMLS(for: searchByMLS) { result in
            switch result {
            case.success(let MLSResult):
                DispatchQueue.main.async {
                    print(MLSResult)
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(favouriteIcon: "heart",
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
                                                             agentCompany: MLSResult[0].Individual?[0].Organization.Name ?? "",
                                                             areaCode: MLSResult[0].Individual?[0].Phones?[0].AreaCode ?? ""
                                                            )
                    )
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMorePropertys else { return }
            page += 1
            homeVCListingAPICall(page: page)
        }
    }
}
