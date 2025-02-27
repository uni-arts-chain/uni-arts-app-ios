import Foundation

enum AccountExportPasswordError: Error {
    case passwordMismatch
}

extension AccountExportPasswordError: ErrorContentConvertible {
    func toErrorContent(for locale: Locale?) -> ErrorContent {
        let message: String

        switch self {
        case .passwordMismatch:
            message = "Password do not match"
        }

        let title = "Error"
        return ErrorContent(title: title, message: message)
    }
}
