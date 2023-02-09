import Foundation
import Data
import Domain

class HttpClientSpy: HttpPostClient {
    private(set) var urls = [URL]()
    private(set) var data: Data?
    private(set) var completion: ((Result<Data?, HttpError>) -> (Void))?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
