//
//  CustomSheet.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct CustomSheet: View {
    //@State private var itemsArray: [NoteModelLocal] = []
    
    @State var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    var onSave: (() -> Void)?
    
    @StateObject var viewModel = NotesViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            
            //Header buttons
            HStack(){
                Text("Cancel")
                    .foregroundStyle(.blue)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .onTapGesture {
                        print("Cancel tapped")
                        dismiss()
                    }
                
                Spacer()
                
                Text("Done")
                    .foregroundStyle(.blue)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .onTapGesture {
                        print("Done tapped")
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                        let dateString = dateFormatter.string(from: viewModel.selectedDate)
                        print("DateString: \(dateString)")
                        
                        if viewModel.targetName != "" && viewModel.descriptionText != ""{
                            viewModel.addNote(title: viewModel.targetName,
                            descr:viewModel.descriptionText,
                            day: dateString,
                            priority: viewModel.selectedPrioriy)
                            
                            onSave?()
                            dismiss()
                        }else {
                            showAlert = true
                        }
                        
                    }
                
            }
            
            .padding(.vertical)
            .padding(.horizontal)
            .zIndex(0)
            
            
            VStack(spacing: 25){
                //First textFiewld
                VStack(){
                    Text("Create Target")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(maxWidth: 335, alignment: .leading)
                    
                    TextField("Type Target", text: $viewModel.targetName)
                        .padding()
                        .frame(width: 335, height: 41)
                        .background(.ultraThinMaterial.opacity(1))
                        .cornerRadius(12)
                        .shadow(radius: 9, x: 0, y: 3)
                }
                
                //Second textField
                VStack(){
                    Text("Description")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(maxWidth: 335, alignment: .leading)
                    
                    TextField("Type description", text: $viewModel.descriptionText)
                        .padding()
                        .frame(width: 335, height: 41)
                        .background(.ultraThinMaterial.opacity(1))
                        .cornerRadius(12)
                        .shadow(radius: 9, x: 0, y: 3)
                }
                
                //Picker days
                VStack{
                    Text("Day of week")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(maxWidth: 335, alignment: .leading)
                    
                    DatePicker("Select date",
                               selection: $viewModel.selectedDate,
                               displayedComponents: [.date])
                    .padding()
                    .datePickerStyle(.compact)
                    .shadow(radius: 4, x: 0, y: 3)
                    .frame(width: 335, height: 41)
                    .background(Color.gray.opacity(0.13))
                    
                    
                    .cornerRadius(12)
                }
                
                //Picker priority
                VStack{
                    Text("Priority")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(maxWidth: 335, alignment: .leading)
                    
                    Picker("Priority", selection: $viewModel.selectedPrioriy) {
                        ForEach(viewModel.priority, id: \.self){ i in
                            Text(i).tag(i)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .cornerRadius(12)
                    .frame(width: 335, height: 41)
                    .shadow(radius: 2, x: 0, y: 3)
                    
                }
            }
            
            .padding(.bottom)
            
            
        }
        .background{
            Image("bg")
                .opacity(0.8)
                .blur(radius: 12)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .overlay {
                    BackdropBlurView(radius: 64)
                }
        }
        
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error52ww"), message: Text("Fill the fields"), dismissButton: .default(Text("OK")))
        }
        
    }
}

#Preview {
    CustomSheet()
}
