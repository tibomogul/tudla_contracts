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

    it "registers a view component class for a slot that has not been registered before" do
      expect do
        described_class.register_view_for_slot(:show_tab, String)
      end.not_to raise_error

      expect(described_class.views_for_slot(:show_tab)).to eq([String])
    end

    it "raises ArgumentError when view_component_class is not a Class" do
      expect do
        described_class.register_view_for_slot(:show_tab, "MyViewComponent")
      end.to raise_error(ArgumentError, "view_component_class must be a Class")
    end
  end
end
