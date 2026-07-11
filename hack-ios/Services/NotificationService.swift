//
//  NotificationService.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import UserNotifications

enum NotificationService {
    static func requestAuthorization() async throws -> Bool {
        try await UNUserNotificationCenter
            .current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]
            )
    }

    static func scheduleReminder(
        id: String,
        title: String,
        body: String,
        date: Date
    ) async throws {
        guard date > .now else {
            throw NotificationError.dateIsInPast
        }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )

        try await UNUserNotificationCenter
            .current()
            .add(request)
    }

    static func cancelReminder(id: String) {
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(
                withIdentifiers: [id]
            )
    }
}

enum NotificationError: LocalizedError {
    case dateIsInPast

    var errorDescription: String? {
        switch self {
        case .dateIsInPast:
            return "The reminder date must be in the future."
        }
    }
}
