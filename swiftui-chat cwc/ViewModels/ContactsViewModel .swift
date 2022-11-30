//
//  ContactsViewModel .swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/26/22.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        // Perform the contact store method asychronously so it doesn't block the UI 
        DispatchQueue.init(label: "getcontacts").async {
            
            do {
                
                // Ask for permission
                let store = CNContactStore()
                
                // List of keys we want to get
                let keys = [CNContactPhoneNumbersKey,
                            CNContactGivenNameKey,
                            CNContactFamilyNameKey] as [CNKeyDescriptor]
                
                // Create a Fetch Request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                // Get the contacts on the user's phone
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
                    
                    // Do something with the contact
                    self.localContacts.append(contact)
                    
                })
                
                // See which local contacts are actually users of this app
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                        
                        // Set the fetched users to the published users property
                        self.users = platformUsers
                    }
                }
                
            }
            catch {
                // Handle error
            }
        }
        
 
    }
    
}
