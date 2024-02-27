//
//  AppDelegate.swift
//  smart to do
//
//  Created by Asif Reddot on 22/2/24.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        setRootNavigation()
        clearCoreDataStorage()
        CoreDataService.shared.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "smart_to_do")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func clearCoreDataStorage() {
        let persistentContainer = NSPersistentContainer(name: "smart_to_do")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print("Failed to load persistent stores: \(error)")
            } else {
                self.deleteAllData(for: persistentContainer)
            }
        }
    }
    
    func deleteAllData(for persistentContainer: NSPersistentContainer) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListITem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

//MARK: Set Root Navigation of the app
extension AppDelegate {
    func setRootNavigation() {
        let customWindow = CustomWindow(frame: UIScreen.main.bounds)
        self.window = customWindow
        
        if let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            let newNavVC = UINavigationController()
            newNavVC.setViewControllers([rootVC], animated: false)
            self.window?.rootViewController = newNavVC
            self.window?.rootViewController?.navigationController?.isNavigationBarHidden = false
            self.window?.makeKeyAndVisible()
        }
    }
}

extension AppDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
