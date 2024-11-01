//
//  EventUpView.swift
//  app911
//
//  Created by Dias Atudinov on 31.10.2024.
//

import SwiftUI

enum EventTab {
    case inProcess, done
}

struct EventUpView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedTab: EventTab = .inProcess
    @State private var editEventShow = false
    @State private var createEventShow = false
    
    @State var selectedTask: Task? = nil
    @State private var addTaskShow = false
    @State private var editTaskShow = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                ZStack {
                    
                    HStack {
                        Text("Events")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                            }.foregroundColor(.mainRed)
                                .font(.system(size: 17, weight: .regular))
                            
                            
                        }
                        Spacer()
                        
                    }
                }.padding(.bottom, 20).padding(.horizontal)
                HStack {
                    Text("Event")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.bottom, 33).padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Statistics")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondRed)
                            
                        }
                    }.padding(.bottom, 10)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.05))
                            .cornerRadius(16)
                        
                        VStack {
                            
                            HStack(spacing: 22) {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 299 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("300")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 599 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("600")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 899 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("900")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 1199 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("1200")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 1499 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("1500")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                
                            }.padding(.horizontal, 20)
                            VStack(spacing: 8) {
                                ProgressView(value: Float16(viewModel.tasks.count * 50), total: 1500)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .accentColor(.mainRed)
                                    .cornerRadius(15)
                                    .scaleEffect(y: 2.5, anchor: .center)
                                    .padding(.horizontal, 30)
                                HStack {
                                    Text("Points received")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                    Spacer()
                                    
                                    Text("Total points")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }.padding(.horizontal, 30)
                            }.padding(.bottom, 25)
                            
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 52)
                                        .foregroundColor(.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.secondRed)
                                        )
                                    
                                    HStack {
                                        Image(systemName: "rosette")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.secondRed)
                                        Text("\(viewModel.tasks.count * 50) p")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.secondRed)
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(height: 52)
                                            .foregroundColor(.mainRed)
                                            .cornerRadius(14)
                                        
                                        HStack {
                                            Image(systemName: "checkmark.seal")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(.white)
                                            Text("Discounts")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                }
                            }.padding(.horizontal, 20)
                            
                        }
                    }.frame(height: 224)
                    
                    HStack {
                        Text("Tasks")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        
                        Button {
                            withAnimation {
                                addTaskShow = true
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondRed)
                        }
                    }
                    
                    Picker("Select a tab", selection: $selectedTab) {
                        Text("In process").tag(EventTab.inProcess)
                        Text("Done").tag(EventTab.done)
                    }.frame(height: 35).pickerStyle(SegmentedPickerStyle()).cornerRadius(7)
                        .onAppear {
                            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                            let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.mainRed]
                            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
                            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
                            UISegmentedControl.appearance().backgroundColor = UIColor(Color.pickerOffGray.opacity(0.24))
                            UISegmentedControl.appearance().selectedSegmentTintColor = .white
                        }
                    
                    
                    
                    if selectedTab == .inProcess {
                        ScrollView(showsIndicators: false){
                            VStack {
                                ForEach(viewModel.tasks.filter({ $0.isArchive == false }), id: \.self) { task in
                                    TaskCell(viewModel: viewModel, task: task) {
                                        //onEdit
                                        selectedTask = task
                                        editTaskShow = true
                                    }
                                }
                            }.padding()
                        }.padding(.horizontal, -16)
                    } else {
                        ScrollView(showsIndicators: false){
                            VStack {
                                ForEach(viewModel.tasks.filter({ $0.isArchive == true }), id: \.self) { task in
                                    TaskCell(viewModel: viewModel, task: task) {
                                        //onEdit
                                        selectedTask = task
                                        editTaskShow = true
                                    }
                                }
                            }.padding()
                        }.padding(.horizontal, -16)
                    }
                    
                    Spacer()
                }.padding(.horizontal)
            }
            
            if addTaskShow {
                VStack {
                    Spacer()
                    AddTaskView(editOrderShow: $addTaskShow, viewModel: viewModel)
                }
            }
            
            if editTaskShow {
                VStack {
                    Spacer()
                    if let task = selectedTask {
                        EditTaskView(editOrderShow: $editTaskShow, viewModel: viewModel, task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    EventUpView(viewModel: HomeViewModel())
}

struct AddTaskView: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State var name = ""
    @State var emplyeeName = ""
    @State var date = Date()
    @State var location = ""
    @State var description = ""
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
    var body: some View {
            
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .ignoresSafeArea(edges: .bottom)
                    .cornerRadius(13)
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        
                        HStack {
                            Button {
                                editOrderShow = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Add a task")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Text("Cancel")
                                .foregroundColor(.clear)
                            
                        }.padding(.horizontal)
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                   
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        
                        TextField("Name", text: $name)
                            .padding(.bottom, 11)
                        Rectangle()
                            .frame(height: 0.34)
                            .foregroundColor(.black.opacity(0.33))
                            .padding(.trailing, -16)
                        
                        HStack {
                            Text(formattedDate(date: date))
                                .padding(11).padding(.horizontal, 0)
                                .onTapGesture {
                                    withAnimation {
                                        datePickerShow.toggle()
                                    }
                                }
                            Spacer()
                        }
                        if datePickerShow {
                            
                            DatePicker(
                                "Choose your date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .background(Color.clear)
                            
                        }
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.trailing, -16)
                        
                        
                        TextField("Location", text: $location)
                            .padding(.vertical, 11)
                        Rectangle()
                            .frame(height: 0.34)
                            .foregroundColor(.black.opacity(0.33))
                            .padding(.trailing, -16)
                        
                        TextField("Description", text: $description)
                            .padding(.vertical, 11)

                        
                    }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)


                    Spacer()
                    
                    Button {
                        if !name.isEmpty && !location.isEmpty && !description.isEmpty {
                            let task = Task(name: name, location: location, date: date, description: description)
                            viewModel.addTask(task)
                            editOrderShow = false
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 52)
                                .cornerRadius(14)
                                .padding(.horizontal)
                                .foregroundColor(.mainRed)
                            Text("Add")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                
                        }
                    }
                    
                    Spacer()
                    
                    
                }
            }.frame(height: UIScreen.main.bounds.height * 0.6)
                .padding(.bottom, isKeyboardVisible ? 0 : -35)
        
        
        .onAppear {
            // Подписываемся на уведомления о клавиатуре
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = false
            }
        }
        .onDisappear {
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

struct EditTaskView: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    @State var task: Task
    
    @State var name = ""
    @State var emplyeeName = ""
    @State var date = Date()
    @State var location = ""
    @State var description = ""
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
    var body: some View {
            
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .ignoresSafeArea(edges: .bottom)
                    .cornerRadius(13)
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        ZStack {
                            HStack {
                                Button {
                                    editOrderShow = false
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Text("Edit a task")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("Cancel")
                                    .foregroundColor(.clear)
                                
                            }.padding(.horizontal)
                            
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        viewModel.deleteTask(task)
                                        editOrderShow = false
                                    }
                                } label: {
                                    
                                    
                                    Image(systemName: "trash")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }.padding(.horizontal)
                            
                        }
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                   
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        
                        TextField("Name", text: $name)
                            .padding(.bottom, 11)
                        Rectangle()
                            .frame(height: 0.34)
                            .foregroundColor(.black.opacity(0.33))
                            .padding(.trailing, -16)
                        
                        HStack {
                            Text(formattedDate(date: date))
                                .padding(11).padding(.horizontal, 0)
                                .onTapGesture {
                                    withAnimation {
                                        datePickerShow.toggle()
                                    }
                                }
                            Spacer()
                        }
                        if datePickerShow {
                            
                            DatePicker(
                                "Choose your date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .background(Color.clear)
                            
                        }
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.trailing, -16)
                        
                        
                        TextField("Location", text: $location)
                            .padding(.vertical, 11)
                        Rectangle()
                            .frame(height: 0.34)
                            .foregroundColor(.black.opacity(0.33))
                            .padding(.trailing, -16)
                        
                        TextField("Description", text: $description)
                            .padding(.vertical, 11)

                        
                    }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)


                    Spacer()
                    
                    Button {
                        if !name.isEmpty && !location.isEmpty && !description.isEmpty {
                            
                            viewModel.editTask(task, name: name, date: date, location: location, description: description)
                            editOrderShow = false
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 52)
                                .cornerRadius(14)
                                .padding(.horizontal)
                                .foregroundColor(.mainRed)
                            Text("Add")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                
                        }
                    }
                    
                    Spacer()
                    
                    
                }
            }.frame(height: UIScreen.main.bounds.height * 0.6)
                .padding(.bottom, isKeyboardVisible ? 0 : -35)
        
        
        .onAppear {
            // Подписываемся на уведомления о клавиатуре
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = false
            }
            
            name = task.name
            date = task.date
            location = task.location
            description = task.description
        }
        .onDisappear {
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}
