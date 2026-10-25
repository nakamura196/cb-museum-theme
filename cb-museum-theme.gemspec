# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "cb-museum-theme"
  spec.version = "0.1.0"
  spec.authors = ["Satoru Nakamura"]
  spec.summary = "Modern and museum looks, with a light/dark switch, for CollectionBuilder sites"
  spec.description = "A Jekyll theme gem for CollectionBuilder-CSV. It adds two looks (modern and museum) " \
                     "built on Bootstrap 5.3 CSS variables, a light/dark switch and a museum-style home layout, " \
                     "without replacing CollectionBuilder's own templates."
  spec.homepage = "https://github.com/nakamura196/cb-museum-theme"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["_layouts/**/*", "_includes/**/*", "_sass/**/*", "assets/**/*", "LICENSE", "README.md"]

  spec.add_runtime_dependency "jekyll", ">= 4.0", "< 5.0"
end
