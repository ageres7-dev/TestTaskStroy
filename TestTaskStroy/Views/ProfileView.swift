//
//  ProfileView.swift
//  TestTaskStroy
//
//  Created by Сергей on 08.04.2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let user: User
    let frends : [User]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                HeaderView(
                    imageName: user.image ?? "",
                    fullName: user.fullName,
                    status: user.status ?? "",
                    deviceImage: user.device ?? "",
                    actionAboutMe: { print("Press About Me Button")}
                )
                .frame(height: 84)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Редактировать")
                        .setCustomStyleButton()
                }
                .padding(.vertical, 8)
                
                HeaderButtons()
                
                Divider()
                
                UserInformation(user: user, numberOfFriends: frends.count)
                
                Divider()
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(user.nickName)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}) {
                    Image(systemName: "qrcode")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/ ) {
                    Image(systemName: "line.horizontal.3")
                }
            }
        }
    }
}


struct HeaderView: View {
    @Environment(\.colorScheme) private var colorScheme
    let imageName: String
    let fullName: String
    let status: String
    let deviceImage: String
    let actionAboutMe: () -> Void
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(fullName)
                    .bold()
                    .font(.title3)
                    .foregroundColor(colorScheme == .light ? .black : .vkWhite)
                Spacer()
                
                Button(action: actionAboutMe) {
                    Text("Расскажите о себе")
                        .font(.callout)
                        .foregroundColor(colorScheme == .light ? .vkLightBlue : .vkDarkBlue)
                }
                Spacer()
                
                HStack {
                    Text(status)
                    Image(systemName: deviceImage)
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
                
            }
            .padding()
            
            Spacer()
            
        }
    }
}

struct HeaderButton: View {
    @Environment(\.colorScheme) private var colorScheme
    let action: () -> Void
    let image: String
    let title: String
    var body: some View {
        
        Button(action: action) {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 18 , height: 18)
                Text(title)
                    .font(.callout)
            }
            .frame(width: 65)
            .foregroundColor(colorScheme == .light ? .vkLightBlue : .vkDarkBlue)
            .font(.callout)
        }
        
    }
}


struct HeaderButtons: View {
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()

            HeaderButton(action: {}, image: "camera", title: "История")
            
            Spacer()
            
            HeaderButton(action: {}, image: "square.and.pencil", title: "Запись")
            
            Spacer()
            
            HeaderButton(action: {}, image: "photo", title: "Фото")
            
            Spacer()
            
            HeaderButton(action: {}, image: "play.rectangle", title: "Клипы")
            
            Spacer()
        }
    }
}


struct InfoItem: View {
    @Environment(\.colorScheme) private var colorScheme
    let info: String?
    let image: String
    let discription: String
    let discriptionButtom: String
    let actionButtom: () -> Void

    var body: some View {
        if let info = info {
            HStack {
                Image(systemName: image)
                    .frame(width: 24, height: 24)
                Text("\(discription) \(info)")
                    .font(.callout)
                    .lineLimit(1)
                Spacer()
            }
            .foregroundColor(colorScheme == .light ? .vkLightGray2 : .vkDarkGray2)
            
        } else {
            Button(action: actionButtom) {
                HStack {
                    Image(systemName: image)
                    Text(discriptionButtom)
                        .font(.callout)
                        .lineLimit(1)
                    Spacer()
                }
                .foregroundColor(colorScheme == .light ? .vkLightBlue : .vkDarkBlue)
            }
        }
        
    }
}

struct UserInformation: View {
    @Environment(\.colorScheme) private var colorScheme
    let user: User
    let numberOfFriends: Int
    
    var body: some View {
        VStack(spacing: 12) {
            InfoItem(
                info: user.city,
                image: "house",
                discription: "Город: ",
                discriptionButtom: "Указать город",
                actionButtom: {}
            )
            
            InfoItem(
                info: user.education,
                image: "graduationcap",
                discription: "Образование: ",
                discriptionButtom: "Указать место учебы",
                actionButtom: {}
            )
           
            Button(action: {}) {
                HStack {
                    Image(systemName: "wave.3.right")
                        .rotationEffect(Angle(degrees: -45))
                        .frame(width: 24, height: 24)
                    Text("\(numberOfFriends) друзей")
                        .font(.callout)
                    Spacer()
                }
                .foregroundColor(colorScheme == .light ? .vkLightGray2 : .vkDarkGray2)
                
            }
            
            InfoItem(
                info: user.work,
                image: "latch.2.case",
                discription: "Место работы: ",
                discriptionButtom: "Указать место работы",
                actionButtom: {}
            )
            
            HStack {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .frame(width: 24, height: 24)
                        Text("Подробная информация")
                            .font(.callout)
                            .bold()
                        Spacer()
                    }
                    .foregroundColor(colorScheme == .light ? .vkLightBlue : .vkWhite)
                }
            }
        }
    }
}

struct Frends: View {
    let frends: [User]
    var body: some View {
        Text("")
    }
}

struct Frends_Previews: PreviewProvider {
    static var previews: some View {
        Frends(frends: User.generateFrends())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            user: User.generateMe(),
            frends: User.generateFrends()
        )
        .preferredColorScheme(.dark)
    }
}
//
//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView(
//            imageName: "sp-studio",
//            fullName: "name",
//            status: "online",
//            deviceImage: "iphone",
//            actionAboutMe: { print("Press About Me Button")}
//        )
//        .frame(height: 84)
//    }
//}
//
//struct HeaderButton_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderButton(action: {}, image: "square.and.pencil", title: "Запись")
//    }
//}
//
//
//struct HeaderButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderButtons()
//    }
//}

//struct UserInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInformation(user: User.generateMeNil(), numberOfFriends: 2)
//    }
//}

