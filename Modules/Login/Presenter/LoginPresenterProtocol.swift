protocol LoginPresenterProtocol: AnyObject {
    func loginUser(email: String, password: String)
    func thereIsAnUserConected() -> String?
    func signOut()
    func isUsedBiometrics() -> Bool
    func setIsUsedBiometrics(with isUsedBiometrics: Bool)
    func loginUserWithBiometrics()
}
