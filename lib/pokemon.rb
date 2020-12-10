class Pokemon
    attr_accessor :name, :type, :id, :db
  
    def initialize (id:, name:, type:, db:)
      @id = id
      @name = name
      @type = type
      @db = db
    end
  
    def self.save(name, type, db)
      sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?);
      SQL
      
      db.execute(sql, [name, type])
      
    end
  
    def self.find(id, db)
      pokemon = db.execute("SELECT * FROM pokemon WHERE id =?;", id).flatten
      Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
    end
  
    def alter_hp(new_hp)
      sql = <<-SQL
        UPDATE pokemon SET hp = ? WHERE id = ?;
      SQL
      db.execute(sql, [new_hp, id])
      end
  end
