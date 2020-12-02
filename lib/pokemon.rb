class Pokemon
  attr_reader :id, :db
  attr_accessor :name, :type

  def initialize(name:, type:, id:, db:)
    @name = name
    @type = type
    @id = id
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    new_poke = db.execute(sql, id)[0]
    Pokemon.new(id: new_poke[0], name: new_poke[1], type: new_poke[2], db: db)
  end
end
