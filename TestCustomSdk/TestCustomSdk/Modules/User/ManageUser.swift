//
//  ManageUser.swift
//  iossdk
//
//  Created by Total Solution on 11/10/22.
//
 
import Foundation
import UIKit
import SwiftyJSON
public class ManageUser {
    public init() {}
    public func RegisterUser(Parameters: Any)->(Any){
        //print("Parameters:", Parameters)
        let JSONString = "\(Parameters)"
        let jsonData = JSONString.data(using: .utf8)!
        let json = try! JSONDecoder().decode(JSON.self, from: jsonData)
        //print("List Count ",json.count)
        let FullName = json["FullName"].stringValue
        let  Email = json["Email"].stringValue
        let DOB = json["DOB"].stringValue
        let Mobile = json["Mobile"].stringValue
        let Education = json["Education"].stringValue
        let Occupation = json["Occupation"].stringValue
        let PinCode = json["PinCode"].stringValue
        let Gender = json["Gender"].stringValue
        
        //get device info
        let device = DeviceInfo()
        let firebasemessagingservice = firebaseMessagingService()
        let JsonData = """
{
"appName": "\(device.getAppName())",
"imei": "\(device.getImei())",
"profile": {
"appVersion": "\(device.getAppVersion())",
"deviceDetails": {
  "Locale": "\(device.getCountry())",
  "Language": "\(device.getLanguage())",
  "Version": "\(device.getDeviceVersion())",
  "Screen": "\(device.getScreenSize())",
  "Manufacturer": "\(device.getDeviceName())",
  "HWModel": "\(device.getDeviceModelName())"
},
"deviceId": "\(device.getDeviceId())",
"identifier": "\(device.getidentifier())",
"imei": "\(device.getImei())",
"platform": "\(device.getPlatform())",
"properties": {},
"token": "\(firebasemessagingservice.getFcmToken())",
"userDetails": {
  "FullName": "\(FullName)",
  "Email": "\(Email)",
  "DOB": "\(DOB)",
  "Mobile": "\(Mobile)",
  "Education": "\(Education)",
  "Occupation": "\(Occupation)",
  "PinCode": "\(PinCode)",
  "Gender": "\(Gender)"
},
"state": "",
"circle": ""
}
}
"""
        print("User Data==>\(JsonData)")
        let postData:String = JsonData
        
        
        
        
        //Call API for User Registration
        let apicall = api()
       // let result = ""
         let result = apicall.Call(requestBody:postData, method:"POST", EventUrl:"register-user")
        if(result as! String == "" || result == nil){
        let um = UserModal()
            um.setFullName(value: FullName)
            um.setDob(value: DOB)
            um.setEmail(value: Email)
            um.setMobile(value: Mobile)
            um.setGender(value: Gender)
            um.setEducation(value: Education)
            um.setOccupation(value: Occupation)
            um.setPinCode(value: PinCode)
         }
        return result
    }
}