//
//  APIService.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

protocol APIServiceProtocol: AnyObject {
    func consumeAPIEndpoint<T: Codable>(request: APIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class APIService: APIServiceProtocol {

    static let shared = APIService()

    private let session: URLSession

    // Se inyecta por dependencias la api para la transferencia de datos de red, por defecto se deja la del sistema.
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Se creo en la api este unico metodo Generico para el acceder a solicituds Http de tipo GET, que es lo unico que se requiere para esta prueba, se podria hacer unos mas generico.
    func consumeAPIEndpoint<T: Codable>(request: APIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        guard let path = URL.concatenateUrl(request.urlApi, finalPath: request.endPoint),
              let pathUrl = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: pathUrl) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)

        if request.method == .get {
            if let urlGet = self.prepareParamsRequestGet(path: pathUrl, params: request.params) {
                urlRequest = URLRequest(url: urlGet)
            }
        } else {
            do {
                try self.setBodyToRequest(urlRequest: &urlRequest, headers: request.headers, body: request.params)
            } catch {
                completion(.failure(APIError.errorBody))
                return
            }
        }

        urlRequest.httpMethod = request.method.rawValue

        self.setHeadersToRequest(urlRequest: &urlRequest, headers: request.headers)

        self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            self?.processData(type: type, completion: completion, data: data, response: response, error: error)
        }.resume()
    }

    internal func prepareParamsRequestGet(path: String, params: [AnyHashable: Any]) -> URL? {
        var newPath = path
        let queryParameters = params.queryParameters
        if !queryParameters.isEmpty {
            newPath = "\(path)?\(queryParameters)"
        }
        return URL(string: newPath)
    }

    internal func setHeadersToRequest(urlRequest: inout URLRequest, headers: [String: String]) {

        var headers = headers

        if headers[HTTPHeader.contentType] == nil {
            headers[HTTPHeader.contentType] = HTTPHeader.applicationJson
        }

        if headers[HTTPHeader.accept] == nil {
            headers[HTTPHeader.accept] = HTTPHeader.applicationJson
        }

        urlRequest.allHTTPHeaderFields = headers
    }

    internal func setBodyToRequest(urlRequest: inout URLRequest, headers: [String: String], body: [AnyHashable: Any]) throws {
        if let contentType = headers[HTTPHeader.contentType], contentType == HTTPHeader.urlEncoded, let newBody = body as? [String: String] {
            var urlComponents = URLComponents()
            urlComponents.queryItems = newBody.map { URLQueryItem(name: $0.key, value: $0.value) }
            urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        } else {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
    }

    internal func processData<T: Codable>(type: T.Type, completion: @escaping (Result<T, Error>) -> Void, data: Data?, response: URLResponse?, error: Error?) {

        // Se verifica que el objeto recibido no sea nil
        guard let data = data else {
            if let error = error {
                completion(.failure(error))
            }
            return
        }

        // Se obtiene el codigo de respuesta de la solicitud
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            completion(.failure(APIError.unexpectedResponse))
            return
        }

        // Se valida que el codigo de respuesta http este entre 200 y 299
        guard HTTPCodes.success.contains(statusCode) else {
            completion(.failure(APIError.httpCode(statusCode)))
            return
        }

        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }

}
