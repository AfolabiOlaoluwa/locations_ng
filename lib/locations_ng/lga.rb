module LocationsNg
  class Lga
    def self.all
      load_lgas
    end

    def self.lgas(state)
      state = state.downcase.gsub(' ', '_')
      all_lgas = load_lgas

      lga_index = all_lgas.index{|l| l['alias'] == state}

      if lga_index.nil?
        {message: "No lgas found for '#{state}'", status: 404}
      else
        all_lgas[lga_index]['lgas']
      end
    end

    private

    def self.load_lgas
      YAML.load(File.read(files_location 'lgas'))
    end

    def self.files_location(file)
      File.expand_path("../locations/#{file}.yml", __FILE__)
    end
  end
end
