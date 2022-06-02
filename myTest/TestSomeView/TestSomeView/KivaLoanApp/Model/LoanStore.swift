//
//  LoanStore.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/1.
//

import Foundation

class LoanStore: Decodable, ObservableObject {
    @Published var loans: [Loan] = []
    
    private static var kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var cachedLoans: [Loan] = []
    
    enum CodingKeys: CodingKey {
        case loans
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loans = try values.decode([Loan].self, forKey: .loans)
    }
    
    init() {

    }
    
    //MARK: Functions
    
    func fetchLatestLoans() {
        guard let loanUrl = URL(string: Self.kivaLoanURL) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            // 解析 JSON 資料
            if let data = data {
                DispatchQueue.main.async {
                    self.loans = self.parseJsonData(data: data)
                    self.cachedLoans = self.loans
                }
            }
            
        }// end Task
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loan] {
        let decoder = JSONDecoder()
        
        do {
            let loanStore = try decoder.decode(LoanStore.self, from: data)
            self.loans = loanStore.loans
        }
        catch {
            print(error)
        }
        return loans
    }
    
    func filterLoans(maxAmount: Int) {
        self.loans = self.cachedLoans.filter {
            $0.amount < maxAmount
        }
    }
}
