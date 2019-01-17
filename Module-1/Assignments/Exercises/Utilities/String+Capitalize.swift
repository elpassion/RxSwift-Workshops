extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

}
