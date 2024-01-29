import SwiftUI

struct SpeakerCard: View {
    var speakerInfo: SpeakerInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(speakerInfo.name)
                .font(.subheadline)
                .bold()
            
            HStack {
                Text(speakerInfo.role)
                    .font(.subheadline)
                
                Text(speakerInfo.company)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
                        
            HStack {
                Image(systemName: "envelope.fill")
                Text(speakerInfo.email)
                    .font(.subheadline)
            }
            
            HStack {
                Image(systemName: "phone.fill")
                Text(speakerInfo.phone)
                    .font(.subheadline)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.vertical)
    }
}

struct SpeakerCard_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCard(speakerInfo: SpeakerInfo(company: "TechCorp", name: "John Doe", role: "Developer", email: "john.doe@example.com", phone: "+1 123-456-7890"))
            .previewLayout(.sizeThatFits)
    }
}
