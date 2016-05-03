namespace :kibokan do
  desc "initilize kibokan-db"
  task :initialize do
    path = "#{Rails.root}/config/kibokan-db/initial"

    Dir.foreach(path) do |namespace|
      next if namespace == '.' || namespace == '..'

      Dir.foreach("#{path}/#{namespace}") do |file_name|
        next if file_name.match(/(\.json)\z/).nil?

        json_raw = File.read("#{path}/#{namespace}/#{file_name}")
        category_hash = JSON.parse(json_raw)

        Category.create(namespace, category_hash)
      end
    end
  end

  desc "update kibokan-db"
  task :update do
    path = "#{Rails.root}/config/kibokan-db/update"

    Dir.foreach(path) do |namespace|
      next if namespace == '.' || namespace == '..'

      Dir.foreach(namespace_path) do |file_name|
        next if file_name.match(/(\.json)\z/).nil?

        json_raw = File.read("#{path}/#{namespace}/#{file_name}")
        category_hash = JSON.parse(json_raw)

        Category.create(namespace, category_hash)
      end
    end
  end
end
