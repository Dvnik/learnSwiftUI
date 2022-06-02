//
//  KivaLoanMainView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/1.
//

import SwiftUI

struct KivaLoanMainView: View {
    @ObservedObject var loanStore = LoanStore()
    
    @State private var filterEnabled = false
    @State private var maximumLoanAmount = 10000.0
    
    var body: some View {
        NavigationView {
            if filterEnabled {
                LoanFilterView(amount: self.$maximumLoanAmount)
                    .transition(.opacity)
            }
            
            List(loanStore.loans) { loan in
                LoanCellView(loan: loan)
                    .padding(.vertical, 5)
                
            }// end list
            .navigationTitle("Kiva Loan")
            // navigationBarItems在XCord上說是即將淘汰的詞綴
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            self.filterEnabled.toggle()
                            self.loanStore.filterLoans(maxAmount: Int(self.maximumLoanAmount))
                        }
                    } label: {
                        Text("Filter")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }

                }
            }// end .toolbar
            
        }// end navigationView
        .navigationViewStyle(.stack)
        .onAppear() {
            self.loanStore.fetchLatestLoans()
        }
        
    }
}

struct KivaLoanMainView_Previews: PreviewProvider {
    static var previews: some View {
        KivaLoanMainView()
    }
}
