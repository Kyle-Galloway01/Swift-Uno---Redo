struct UndoRedoManager<T> {
    private var undoStack = Stack<T>()
    private var redoStack = Stack<T>()

    mutating func type(_ text: T) {
        undoStack.push(text)
        redoStack = Stack<T>() // Clear redo stack after new typing
    }

    mutating func undo() -> T? {
        if let item = undoStack.pop() {
            redoStack.push(item)
            return item
        }
        return nil
    }

    mutating func redo() -> T? {
        if let item = redoStack.pop() {
            undoStack.push(item)
            return item
        }
        return nil
    }

    var canUndo: Bool {
        return !undoStack.isEmpty
    }

    var canRedo: Bool {
        return !redoStack.isEmpty
    }
}

// Example usage
var textUndoRedo = UndoRedoManager<String>()
textUndoRedo.type("Hello")
textUndoRedo.type(" World!")
print("Current text:", textUndoRedo.undo() ?? "")
textUndoRedo.type(" OpenAI")
print("Current text:", textUndoRedo.undo() ?? "")
print("Can redo:", textUndoRedo.canRedo)
print("Redo:", textUndoRedo.redo() ?? "")
print("Redo:", textUndoRedo.redo() ?? "")
