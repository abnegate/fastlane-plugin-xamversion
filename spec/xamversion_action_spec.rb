describe Fastlane::Actions::XamversionAction do
  describe "#run" do
    it "prints a message" do
      expect(Fastlane::UI).to receive(:message).with("The xamversion plugin is working!")

      Fastlane::Actions::XamversionAction.run(nil)
    end
  end
end
