def load_config(key, filepath)
  yml = YAML.load_file filepath rescue nil
  abort "No such file #{filepath}" unless yml

  config = yml[Rails.env]
  abort "No such environment #{Rails.env} on #{filepath}" unless config

  Rails.application.config.send(
    "#{key}=".to_sym,
    ActiveSupport::InheritableOptions.new(config.deep_symbolize_keys)
  )
end

load_datas = {
  global_config: 'config/application_config.yml',
}

load_datas.each do |key, path|
  load_config(key, path)
end
