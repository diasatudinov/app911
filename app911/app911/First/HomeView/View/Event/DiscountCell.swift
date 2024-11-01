//
//  DiscountCell.swift
//  app911
//
//  Created by Dias Atudinov on 01.11.2024.
//

import SwiftUI

struct DiscountCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var discount: Discount
    @State private var showTicket = false
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading,spacing: 10) {
                HStack {
                    Text(discount.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    if discount.isArchive {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.secondRed)
                    } else {
                        Button {
                            viewModel.toggleArchive(discount)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondRed)
                        }
                    }
                }
                
                Text(discount.description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black.opacity(0.7))
                    .frame(maxHeight: 63)
                    
                
                
            }.padding(.horizontal).padding(.top).padding(.bottom)
        }.frame(maxWidth: .infinity).overlay(
        RoundedRectangle(cornerRadius: 14)
            .stroke(lineWidth: 1).foregroundColor(.secondRed)
        )
        
    }
}

#Preview {
    DiscountCell(viewModel: HomeViewModel(), discount: Discount(name: "Super Saturday", description: "Every Saturday, get 20% off all items in the shop. Hurry up, the offer is valid for one day only!"))
}
