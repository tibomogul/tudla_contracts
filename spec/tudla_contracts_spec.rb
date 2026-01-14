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
