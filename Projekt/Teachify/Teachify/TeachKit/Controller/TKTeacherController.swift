//
//  TKTeacherController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

struct TKTeacherController {
    private var offlineCloud = OfflineCloud.server
    
    // MARK: - Student Group Operations
    func fetchUserGroups(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                         completion: @escaping ([String], TKError?) -> ()) {
        randomDelay {
            let teacherGroups = self.offlineCloud.teacherGroups
            completion(teacherGroups, nil)
        }
    }
    
    func fetchStudents(inGroup groupName: String,
                       withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                       completion: @escaping ([TKStudent], TKError?) -> ()) {
        randomDelay {
            if let fetchedStudents = self.offlineCloud.teacherGroupsDic[groupName] {
                completion(fetchedStudents, nil)
            } else {
                completion([], TKError.classGroupDoesNotExist)
            }
        }
    }
    
    func createGroup(withClassGroupName classGroupName: String) {
        randomDelay {
            let newGroupName = classGroupName
            self.offlineCloud.teacherGroups.append(newGroupName)
            self.offlineCloud.teacherGroupsDic[newGroupName] = []
        }
    }
    
    func update(oldClassGroupName: String, withNewClassGroupName newClassGroupName: String, completion: @escaping ([String], TKError?) -> ()) {
        randomDelay {
            for index in 0..<self.offlineCloud.teacherGroups.count {
                let classGroupName = self.offlineCloud.teacherGroups[index]
                if classGroupName == oldClassGroupName {
                    self.offlineCloud.teacherGroups.remove(at: index)
                    self.offlineCloud.teacherGroups.insert(newClassGroupName, at: index)
                    break
                }
            }
            let classGroupNames = self.offlineCloud.teacherGroups
            completion(classGroupNames, nil)
        }
    }
    
    func delete(classGroupName: String, completion: @escaping (TKError?) -> ()) {
        randomDelay {
            for index in (0..<self.offlineCloud.teacherGroups.count).reversed() {
                let groupName = self.offlineCloud.teacherGroups[index]
                if classGroupName == groupName {
                    self.offlineCloud.teacherGroups.remove(at: index)
                    self.offlineCloud.teacherGroupsDic[groupName] = nil
                    completion(nil)
                }
            }
            completion(nil)
        }
    }
    
    func add(students: [TKStudent], toGroupName groupName: String, completion: @escaping (TKError?) -> ()) {
        randomDelay {
            let studentsToAdd = students
            if var studentGroup = self.offlineCloud.teacherGroupsDic[groupName] {
                studentGroup.append(contentsOf: studentsToAdd)
                self.offlineCloud.teacherGroupsDic[groupName] = studentGroup
                completion(nil)
            } else {
                completion(TKError.classGroupDoesNotExist)
            }
        }
    }
    
    func remove(students: [TKStudent], fromGroupName groupName: String, completion: @escaping (TKError?) -> ()) {
        randomDelay {
            let studentsToRemove = students
            if var cloudGroup = self.offlineCloud.teacherGroupsDic[groupName] {
                for i in 0..<studentsToRemove.count {
                    let studentToRemove = studentsToRemove[i]
                    
                    for m in (0..<cloudGroup.count).reversed() {
                        let cloudStudent = cloudGroup[m]
                        if cloudStudent == studentToRemove {
                            cloudGroup.remove(at: m)
                            self.offlineCloud.teacherGroupsDic[groupName] = cloudGroup
                        }
                    }
                }
            }
            completion(nil)
        }
    }
}






