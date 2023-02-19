protocol LoginPresenterProtocol: AnyObject {
    func loginUser(email: String, password: String)
    func thereIsAnUserConected() -> String?
    func signOut()
}
