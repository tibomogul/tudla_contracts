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

    # Stub a ViewComponent base class and subclass for testing
    let(:view_component_base) do
      stub_const("ViewComponent", Class.new)
    end

    let(:view_component_subclass) do
      Class.new(view_component_base)
    end

    it "registers a view component instance for a slot that has not been registered before" do
      component = view_component_subclass.new
      expect do
        described_class.register_view_for_slot(:show_tab, component)
      end.not_to raise_error

      expect(described_class.views_for_slot(:show_tab)).to eq([component])
    end

    it "raises ArgumentError when view_component is not a ViewComponent instance" do
      expect do
        described_class.register_view_for_slot(:show_tab, "MyViewComponent")
      end.to raise_error(ArgumentError,
                         "view_component must be an instance of a class that inherits from ViewComponent")
    end
  end
end
