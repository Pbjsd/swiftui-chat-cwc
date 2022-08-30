//
//  ContactsViewModel .swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/26/22.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
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
                
                // TODO: See which local contacts are actually users of this app 
                
            }
            catch {
                // Handle error
            }
        }
        
 
    }
    
}
