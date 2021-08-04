
// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

// 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

struct Post {
    var id: Int
    var title: String
    var text: String
}

enum PostError: Error {
    case notFound
    case forbidden
    case anotherError(errorString: String)
}

class Article {
    private var items: [Post] = []

    func create(post: Post) {
        items.append(post)
    }

    func get(id: Int) -> Post? {
        switch findData(id: id) {
        case let .success(post):
            return post
        default:
            return nil
        }
    }

    func update(id: Int, post: Post) throws -> Bool {
        switch findIndex(id: id) {
        case let .success(index):
            items[index] = post
        default:
            throw PostError.anotherError(errorString: "An unexpected error occurred")
        }
        return true
    }

    // Тут просто всегда будет ошибка
    func delete(id: Int) throws {
        switch findIndex(id: id) {
        case let .failure(err):
            throw err
        default:
            throw PostError.forbidden
        }
    }
}

extension Article {
    private func findIndex(id: Int) -> Result<Int, Error> {
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return Result.failure(PostError.notFound)
        }
        return Result.success(index)
    }

    private func findData(id: Int) -> Result<Post, Error> {
        guard let post = items.filter({ item in item.id == id }).first else {
            return Result.failure(PostError.notFound)
        }
        return Result.success(post)
    }
}

let article = Article()
article.create(post: Post(id: 1, title: "Post 1", text: "text"))

// Вызов и обработка результата метода который завершается неудачей
if let post = article.get(id: 1) {
    print("Print post: \(post)")
} else {
    print("Post Not Found!")
}

// Вызов и обработка результата метода который может выбрасывать ошибки (Обновление)
do {
    if try article.update(id: 100_500, post: Post(id: 2, title: "Post 2", text: "text 2")) {
        print("The post has been updated")
    }
} catch PostError.notFound {
    print("Post Not Found!")
} catch let PostError.anotherError(errorString) {
    print(errorString)
}

// Вызов и обработка результата метода который может выбрасывать ошибки (Удаление)
do {
    try article.delete(id: 1)
} catch PostError.forbidden {
    print("Forbidden delete post")
} catch {
    print("Unexpected error: \(error).")
}
