import FirebaseAuth

class LoginDataManager: LoginDataManagerProtocol {
    func loginUser(email: String, password: String, completion: @escaping (Result<DtoUser, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result, error == nil {
                let user = DtoUser.init(id: result.user.uid, name: result.user.displayName ?? "", email: result.user.email!, photoUrl: result.user.photoURL?.absoluteString)
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
}
