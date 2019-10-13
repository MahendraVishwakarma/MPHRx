import Foundation

// generics type
public enum Result<T, U> where U:Error{
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error{
    
    case failedRequest(String?)
}

// hTTPS methods type
public enum HttpsMethod{
    case Post
    case Get
    case Put
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
            
        }
        
    }
}

public enum PhotoLayouts{
    case two
    case three
    case four
    var localise:Int{
        switch self {
        case .two:
            return 2
        case .three:
            return 3
        case.four:
            return 4
    }
    }
}
