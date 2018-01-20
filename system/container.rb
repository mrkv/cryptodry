require 'dry/system/container'

# https://github.com/dry-rb/dry-system/commit/e1433dfbabb3f0e08b96c7e66223cae77fc5d079
# TODO: remove when https://github.com/dry-rb/dry-inflector/pull/19 will be ready
class CustomLoader < Dry::System::Loader
  def initialize(path, inflector = Dry::Inflector.new)
    super
    @inflector = ActiveSupport::Inflector
  end
end

class Container < Dry::System::Container
  configure do |config|
    config.loader = CustomLoader
    config.root = File.expand_path('../../', __FILE__)
    config.auto_register = %w[core/gateways core/use_cases]
  end

  load_paths!('core')
end
