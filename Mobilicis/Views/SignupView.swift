import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var CurrentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @State private var isShowingImagePicker = false
    @State private var image: UIImage?
    
    
    struct CustomTextField: View {
        var image: String
        @Binding var text: String
        var placeholder: String

        var body: some View {
            HStack {
                Image(systemName: image)
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.white, lineWidth: 1))
            .padding(.horizontal)
        }
    }

    struct CustomSecureField: View {
        var image: String
        @Binding var text: String
        var placeholder: String

        var body: some View {
            HStack {
                Image(systemName: image)
                    .foregroundColor(.gray)
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.white, lineWidth: 1))
            .padding(.horizontal)
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Create an Account")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                Button(action: { isShowingImagePicker = true }) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    } else {
                        Circle()
                            .fill(Color.white.opacity(0.5))
                            .overlay(Text("Add Photo").foregroundColor(.white))
                            .frame(width: 150, height: 150)
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $image)
                }
                Spacer()
                CustomTextField(image: "person", text: $name, placeholder: "Full Name")
                CustomTextField(image: "mail", text: $email, placeholder: "Email")
                CustomSecureField(image: "lock", text: $password, placeholder: "Password")
                
                Button(action: {
                    withAnimation { CurrentShowingView = "login" }
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Button(action: createUserAccount) {
                    Text("Create New Account")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.8)))
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func createUserAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let authResult = authResult {
                userID = authResult.user.uid
                uploadProfileData()
            }
        }
    }
    
    private func uploadProfileData() {
        let db = Firestore.firestore()
        let randomScore = Int.random(in: 1000..<5000)
        let storageRef = Storage.storage().reference().child("profile_images/\(userID).jpg")
        
        if let uploadData = image?.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil) { _, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                storageRef.downloadURL { url, _ in
                    if let profileImageUrl = url?.absoluteString {
                        let userData: [String: Any] = [
                            "name": name, "email": email, "score": randomScore, "profileImageUrl": profileImageUrl
                        ]
                        db.collection("users").document(userID).setData(userData) { error in
                            if let error = error {
                                print("Error writing document: \(error)")
                            } else {
                                print("User data successfully written to Firestore")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    @State static var currentShowingView = "signup"

    static var previews: some View {
        SignupView(CurrentShowingView: $currentShowingView)
    }
}
