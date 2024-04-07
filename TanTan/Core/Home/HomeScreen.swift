//
//  HomeScreen.swift
//  TanTan
//
//  Created by Run on 2024/4/7.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        if viewModel.hasMoreCard {
            CardContainerView(viewModel: viewModel)
        } else {
            NoResultView()
        }
        
    }
}

#Preview {
    HomeScreen()
}
