//
//  DataPersistenceManger.swift
//  v3
//
//  Created by Jun on 2023-02-17.
//

import UIKit
import CoreData


class DataPersistenceManger {
    
    static let shared = DataPersistenceManger()
    
    func toSavedProperty(model: TitlePreviewViewModel, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        
//        short way to do the contextr
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = PropertyItem(context: context)
        
//        item.image = model.propertyImage
        item.price = model.price
        item.address = model.address
        item.mlsNumber = model.MlsNumber
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    //completion: @escaping (Swift.Result<PropertyItem, Error>) -> Void
    func fetchingSavedFromDataBase(completion: @escaping (Swift.Result<[PropertyItem], Error>) -> Void) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
//        let request: NSFetchRequest<PropertyItem>
//
//        request = PropertyItem.fetchRequest()
        
//        shorter way
//        context.fetch(PropertyItem.fetchRequest())
        do {
//            let property = try context.fetch(request)
            let property = try context.fetch(PropertyItem.fetchRequest())
            completion(.success(property))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    func deletePropertyWith(model: PropertyItem, completion: @escaping (Swift.Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
        }
    }
}
