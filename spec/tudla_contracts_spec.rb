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

    it "registers a view definition instance for a slot that has not been registered before" do
      definition = TudlaContracts::Integrations::ViewDefinitions::ShowTabDefinition.new(
        id: :test_tab,
        label: "Test Tab",
        component_class: "TestComponent"
      )
      expect do
        described_class.register_view_for_slot(:show_tab, definition)
      end.not_to raise_error

      expect(described_class.views_for_slot(:show_tab)).to eq([definition])
    end

    it "raises ArgumentError when view_definition does not inherit from ViewDefinitions::Base" do
      expect do
        described_class.register_view_for_slot(:show_tab, "NotAViewDefinition")
      end.to raise_error(ArgumentError,
                         "view_definition must be an instance of a class that inherits from ViewDefinitions::Base")
    end
  end
end
