config = YAML::load(
  ERB.new(IO.read('config/global_config.yml')).result
)[Rails.env]

Rails.application.config.global_config =
  ActiveSupport::InheritableOptions.new(config.deep_symbolize_keys)
