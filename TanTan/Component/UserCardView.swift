//
//  UserCardView.swift
//  TanTan
//
//  Created by Run on 2024/4/7.
//

import SwiftUI

struct UserCardView: View {
    var userCard: UserCard
    var swipeAction: (()->Void)?
    @State var imageIndex = 0
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader { proxy in
            let frameWidth = proxy.size.width
            let frameHeight = proxy.size.height
            ZStack(alignment: .top) {
                Image(userCard.photos[imageIndex])
                    .resizable()
                    .frame(width: frameWidth, height: frameHeight)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                HStack {
                    Rectangle()
                        .onTapGesture {
                            updateImageIndex(hasMoreImage: false)
                        }
                    Rectangle()
                        .onTapGesture {
                            updateImageIndex(hasMoreImage: true)
                        }
                }
                .foregroundColor(.white.opacity(0.01))
                HStack {
                    ForEach(0..<userCard.photos.count, id: \.self) { imageIndex in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 4)
                            .foregroundColor(self.imageIndex == imageIndex ? .white : .gray.opacity(0.5))
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal)
                VStack {
                    HStack {
                        if offset.width > 0 {
                            createUserCardLabel(title:"LIKE", degree:-20, color: .green)
                            Spacer()
                        } else if offset.width < 0 {
                            Spacer()
                            createUserCardLabel(title:"NOPE", degree:20, color: .red)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    Spacer()
                    createUserCardBottomInfo()
                }
            }
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .rotationEffect(Angle(degrees: getRotateAmount()))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.easeOut(duration: 0.2)) {
                            offset = value.translation
                        }
                    })
                    .onEnded({ value in
                        withAnimation(.easeOut(duration: 0.2)) {
                            let screenCutoff = frameWidth / 2 * 0.8
                            let translation = value.translation.width
                            let checkStatus = translation > 0 ? translation : -translation
                            if checkStatus > screenCutoff {
                                offset = CGSize(width: translation > 0 ? frameWidth : -frameWidth, height: value.translation.height)
                                swipeAction?()
                            } else {
                                offset = .zero
                            }
                        }
                    })
            )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 -  min(percentage, 0.7) * 0.3;
    }
    
    func getRotateAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        return Double(percentage * 10)
    }
    
    func updateImageIndex(hasMoreImage: Bool) {
        let nextIndex = hasMoreImage ? imageIndex + 1: imageIndex - 1
        imageIndex = min(max(0, nextIndex), userCard.photos.count - 1)
    }
    
    func createUserCardLabel(title: String, degree: Double, color: Color) -> some View {
        Text(title)
            .tracking(3)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 3)
            )
            .rotationEffect(.degrees(degree))
    }
    
    func createUserCardBottomInfo() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(userCard.name),\(userCard.age)")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                HStack {
                    Text(userCard.zodiac)
                        .fontWeight(.bold)
                        .padding(5)
                        .background(.white.opacity(0.3))
                        .cornerRadius(5)
                    Text(userCard.place)
                }
                    
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 30))
                    .padding(8)
            }
        }
        .foregroundColor(.white)
        .padding()
        .padding(.bottom, 60)
        .background(
            LinearGradient(colors: [Color.black.opacity(0.9), Color.clear], startPoint: .bottom, endPoint: .top)
        )
        .cornerRadius(20)
        .clipped()
    }
    
}

#Preview {
    UserCardView(userCard: UserCard(name: "Jame", age: 10, place: "NYC", zodiac: "Cancer", photos: ["User1", "User2"]))
}
