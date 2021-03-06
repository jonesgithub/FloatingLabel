//
//  DataValidationHelper.swift
//  FloatingLabel
//
//  Created by Kevin Hirsch on 16/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import Foundation

internal struct DataValidationHelper {
	
	static func isAddressEmailValid(email: String) -> Bool {
		let pattern = "^(?:[A-Za-z0-9_\\!\\#\\$\\%\\&\\'\\*\\+\\-\\/\\=\\?\\^\\`\\{\\|\\}\\~]+\\.)*[A-Za-z0-9_\\!\\#\\$\\%\\&\\'\\*\\+\\-\\/\\=\\?\\^\\`\\{\\|\\}\\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\\-](?!\\.)){0,61}[a-zA-Z0-9]?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\\[(?:(?:[01]?\\d{1,2}|2[0-4]\\d|25[0-5])\\.){3}(?:[01]?\\d{1,2}|2[0-4]\\d|25[0-5])\\]))$"
		let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
		
		return regex.matchesInString(email, options: [], range: NSMakeRange(0, email.characters.count)).count > 0
	}
	
	static func isPhoneNumberValid(phone: String) -> Bool {
		let pattern = "^\\+[0-9]{7,15}$"
		let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
		
		return regex.matchesInString(phone, options: [], range: NSRange(location: 0, length: phone.characters.count)).count > 0
	}
	
}
