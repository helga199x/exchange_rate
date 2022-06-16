require_relative "lib/exchange_rate/version"

Gem::Specification.new do |spec|
  spec.name          = "exchange_rate"
  spec.version       = ExchangeRate::VERSION
  spec.authors       = ["Example"]
  spec.email         = ["example@example.com"]

  spec.summary       = "Exchange rate"
  spec.description   = "Exchange rate"
  spec.required_ruby_version = ">= 2.4.0"

  root = File.expand_path('..', __FILE__)

  spec.files = Dir
                   .glob(File.join(root, "**", "*.rb"))
                   .reject { |f| f.match(%r{^(test|spec|features)/}) }
                   .map { |f| Pathname.new(f).relative_path_from(root).to_s }

  spec.require_paths = ["lib"]
end
