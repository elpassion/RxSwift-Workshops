@testable import Workshops_Module2
import Nimble
import Quick
import RxSwift

class TimetableEntryCellSpec: QuickSpec {

    override func spec() {
        describe("TimetableEntryCell") {
            var sut: TimetableEntryCell!

            beforeEach {
                sut = TimetableEntryCell()
            }

            afterEach {
                sut = nil
            }

            context("when reused") {
                var previousDisposeBag: DisposeBag!

                beforeEach {
                    previousDisposeBag = sut.disposeBag
                    sut.timeLabel.text = "Time test"
                    sut.nameLabel.text = "Name test"
                    sut.didTapCheckInButton = {}

                    sut.prepareForReuse()
                }

                afterEach {
                    previousDisposeBag = nil
                }

                it("should clean time label text") {
                    expect(sut.timeLabel.text).to(beNil())
                }

                it("should clean name label text") {
                    expect(sut.nameLabel.text).to(beNil())
                }

                it("should clean didTapCheckInButton closure") {
                    expect(sut.didTapCheckInButton).to(beNil())
                }

                it("should rebuild dispose bag") {
                    expect(previousDisposeBag) !== sut.disposeBag
                }
            }

            context("when tap button") {
                var buttonWasTapped: Bool!

                beforeEach {
                    buttonWasTapped = false

                    sut.didTapCheckInButton = {
                        buttonWasTapped = true
                    }

                    sut.checkInButton.simulateTap()
                }

                afterEach {
                    buttonWasTapped = nil
                }

                it("should invoke didTapCheckInButton action") {
                    expect(buttonWasTapped) == true
                }
            }
        }
    }

}
