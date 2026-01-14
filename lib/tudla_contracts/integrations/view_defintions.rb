# frozen_string_literal: true

Dir.glob(File.join(__dir__, "view_definitions/**/*.rb")).each { |file| require file }
