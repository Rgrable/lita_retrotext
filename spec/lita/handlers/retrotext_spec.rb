require "spec_helper"

describe Lita::Handlers::RetroText, lita_handler: true do
  let(:bot) {Lita::Robot.new(registry)}

  subject {described_class.new(robot)}

  describe "#retrotext" do
    it 'should display the url' do
      send_message("Lita retro Top_text Middle_text Bottom_text")
      expect(replies[0]).to match(/^http:\/\/([a-zA-Z0-9\/_\-.]+)\.jpg/i)
    end
  end
end