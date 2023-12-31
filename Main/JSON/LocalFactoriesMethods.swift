import Foundation
import Data

func makeLocalFetchData(forResource: String, withExtension: String) -> LocalFetchData {
    return LocalFetchData(forResource: forResource, withExtension: withExtension)
}

func makeLocalPostData(fileName: String) -> LocalPostData {
    return LocalPostData(fileName: fileName)
}
