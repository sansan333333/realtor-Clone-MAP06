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
}
