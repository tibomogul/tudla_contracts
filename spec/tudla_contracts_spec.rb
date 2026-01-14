# frozen_string_literal: true

RSpec.describe TudlaContracts do
  it "has a version number" do
    expect(TudlaContracts::VERSION).not_to be nil
  end
end

RSpec.describe TudlaContracts::Integrations::ViewDefinitions::ShowTabDefinition do
  it "is defined" do
    expect(described_class).to be_a(Class)
  end
end

RSpec.describe TudlaContracts::Integrations::Registry do
  describe ".register_view_for_slot" do
    before { described_class.reset! }

    it "registers a view component for a slot that has not been registered before" do
      expect do
        described_class.register_view_for_slot(:show_tab, "MyViewComponent")
      end.not_to raise_error

      expect(described_class.views_for_slot(:show_tab)).to eq(["MyViewComponent"])
    end
  end
end
