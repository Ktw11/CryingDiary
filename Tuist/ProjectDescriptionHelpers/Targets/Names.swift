import ProjectDescription

public enum Names {
    public static let app = "App"
    
    public static let cryingDiary = "CryingDiary"
    public static let feature = "Feature"
    public static let core = "Core"
    public static let thirdParty = "ThirdParty"
    public static let domain = "Domain"
    public static let repository = "Repository"
    public static let network = "Network"
    public static let sharedResource = "SharedResource"
    
    public enum Feature: String, CaseIterable {
        case home = "Home"
        case signIn = "SignIn"
        case newPost = "NewPost"
    }
}
