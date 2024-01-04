    //
    //  AuthViewModel.swift
    //  RestaurantFinder
    //
    //  Created by Vihaan Deepak Phal on 11/3/23.
    //
    import Firebase
    import Foundation
    import FirebaseFirestoreSwift

    protocol AuthenticationFormProtocol {
        var formIsValid: Bool { get }
    }
    @MainActor
    class AuthViewModel: ObservableObject {
        //firebase user object
        @Published var userSession: FirebaseAuth.User?
        
        //our user
        @Published var currentUser: User?
        init() {
            self.userSession = Auth.auth().currentUser
            
            Task{
                await fetchUser()
            }
        }
        
        func signIn(withEmail email: String, password: String) async throws {
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                self.userSession = result.user
                await fetchUser()
            } catch {
                print("DEBUG: failed to log-in user with error \(error.localizedDescription)")
            }
        }

        func createUser(withEmail email: String, password: String, fullname: String) async throws {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                self.userSession = result.user
                let user = User(id: result.user.uid, fullname: fullname, email: email)
                // Additional user data handling if needed
                await fetchUser()
            } catch {
                print("DEBUG: failed to create user with error \(error.localizedDescription)")
            }
        }

        
        
        func signOut() {
            
            //clientside signout - take back to loginscreen
            // signout from firebase
            do{
                try Auth.auth().signOut() 
                self.userSession = nil
                self.currentUser = nil
                
            }catch{
                print("DEBUG: filed to sinout with error\(error.localizedDescription)")
            }
        }
        
        
        func deleteAccount() {
            
            
        }
        
        
        func fetchUser() async {
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
            
            self.currentUser = try? snapshot.data(as: User.self)
            
            print("DEBUG: Current user is \(self.currentUser)")
            
            
        }
        
    }


