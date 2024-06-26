//
//  CardContainerView.swift
//  TanTan
//
//  Created by Run on 2024/4/7.
//

import SwiftUI

struct CardContainerView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            ForEach(viewModel.displayingCard.reversed()) { card in
                UserCardView(userCard: card, swipeAction: viewModel.nextUserCard)
            }
            if viewModel.hasMoreCard {
                HStack {
                    ForEach(ButtonType.allCases) { type in
                        RoundButton(type: type, action: {
                            switch type {
                            case .back:
                                debugPrint("Rollback")
                            case .no:
                                viewModel.nextUserCard()
                            case .heart:
                                viewModel.nextUserCard()
                            case .star:
                                debugPrint("Super Like")
                            }
                        
                        })
                            .frame(height: 45)
                    }
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 50)
    }
}

#Preview {
    CardContainerView(viewModel: HomeViewModel())
}
