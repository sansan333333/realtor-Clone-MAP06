//
//  FavoriteViewController.swift
//  v3
//
//  Created by Jun on 2023-02-07.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let CoreDataTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CoreDataTableViewCell.self, forCellReuseIdentifier: CoreDataTableViewCell.identifier)
        return table
    }()
    
    private var propertyItems: [PropertyItem] = [PropertyItem]()
    
//    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(CoreDataTableView)
        
        CoreDataTableView.delegate = self
        CoreDataTableView.dataSource = self
        
        fetchFromCoreDataForSaved()
        
        
        
//        CoreDataTableView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
    }
    
    
    
    
    
    
    
    
//    @objc private func refreshData(_ sender: Any) {
//        // Reload the data here
//        CoreDataTableView.reloadData()
//        refreshControl.endRefreshing()
//    }
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFromCoreDataForSaved()
    }
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CoreDataTableView.frame = view.bounds
    }
    
    func fetchFromCoreDataForSaved() {
        
        DataPersistenceManger.shared.fetchingSavedFromDataBase { [weak self] result in
            switch result {
            case.success(let items):
                self!.propertyItems = items
                DispatchQueue.main.async {
                    self!.CoreDataTableView.reloadData()
                    
                }
            case.failure(let error):
                print("error happened @ FavoriteViewController 52")
                print(error.localizedDescription)
            }
            
        }
        //        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //
        //        do {
        //            self.propertyItems = try context.fetch(PropertyItem.fetchRequest())
        //            DispatchQueue.main.async {
        //
        //                self.CoreDataTableView.reloadData()
        //                print("will load tableiew")
        //            }
        //        }catch{
        //
        //        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoreDataTableViewCell.identifier, for: indexPath) as? CoreDataTableViewCell else {
            return UITableViewCell()
        }
        
        let property = propertyItems[indexPath.row]
        cell.config(with: ListingViewModel(priceLabel: property.price!, addressLable: property.address!, ListImageURL: "image"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManger.shared.deletePropertyWith(model: propertyItems[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted fromt the database")
                case .failure(let error):
                    print("error happened @ FavoriteViewController 100")
                    print(error.localizedDescription)
                }
                self?.propertyItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        let property = propertyItems[indexPath.row]
        
        

        guard let propertyMls = property.mlsNumber else {
            print("no propertyMls + @ FavoriteViewController 117")
            return
        }
        
        //let property = propertyItems[indexPath.row] = "MLS : 26484134"
        
        let newPropertyMls = propertyMls.replacingOccurrences(of: "MLS : ", with: "")
        
        print(newPropertyMls)
        
        APICaller.shared.SearchByMLS(for: newPropertyMls) { [weak self] result in
            switch result {
            case .success(let MLSResult):
                DispatchQueue.main.async {
                    print(MLSResult)
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(favouriteIcon: "heart",
                                                             shareIcon: "heart",
                                                             propertyImage: (MLSResult[0].Property?.Photo![0].HighResPath)!,
                                                             price: (MLSResult[0].Property?.Price ?? ""),
                                                             address: (MLSResult[0].Property?.Address?.AddressText ?? ""),
                                                             bedroomNum: (MLSResult[0].Building?.Bedrooms ?? ""),
                                                             propertyInfoDetailes: (MLSResult[0].PublicRemarks)!,
                                                             MlsNumber: (MLSResult[0].MlsNumber)!
                                                            ))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print("no propertyMls + @ FavoriteViewController 142")
                print(error.localizedDescription)
            }
        }
    }
}

