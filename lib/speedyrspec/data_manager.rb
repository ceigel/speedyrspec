module SpeedyRspec
  class DataManagerFactory
    def self.create_manager
      case SpeedyRspec.trace_type
      when :sqlite
        SqliteDataManager.new
      else
        HashDataManager.new
      end
    end
  end

  class HashDataManager
    def initialize
      @data = Hash.new{|h, k| h[k] = Set.new}
    end

    def add_dependency(from, to)
      @data[from].add(to)
    end

    def finish
      File.write(SpeedyRspec.trace_file, to_json)
    end

    private

    def to_json
      JSON.pretty_generate(@data.map{|k,v| [k, Array(v)]}.to_h)
    end
  end

  class SqliteDataManager
    def initialize
      @db = Sequel.sqlite(SpeedyRspec.trace_file)
      set_db_schema
    end

    def add_dependency(from, to)
      add_to(add_from(from), to)
    end

    def finish
      @db.disconnect
    end

    private

    def add_from(file)
      v = @db[:from].first(file: file)
      return v[:id] if v
      @db[:from].insert(file: file)
    end

    def add_to(from_id, file)
      v = @db[:to].first(from_id: from_id, file: file)
      return v[:id] if v
      binding.pry
      @db[:to].insert(from_id: from_id, file: file)
    end

    def set_db_schema
      @db.drop_table('from', if_exists: true)
      @db.drop_table('to', if_exists: true)
      @db.create_table('from') do
        primary_key :id
        string :file, index: {unique: true, null: false}
      end

      @db.create_table('to') do
        foreign_key :id, :from, name: 'from_id'
        string :file, index: {unique: true, null: false}
      end
    end
  end
end
