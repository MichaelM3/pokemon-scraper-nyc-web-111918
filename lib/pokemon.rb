class Pokemon

  attr_reader :name, :type, :db
  attr_accessor :id, :hp

  @@all = []

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
    @hp = hash[:hp]

    @@all << self
  end

  def self.all
    @@all
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES ('#{name}', '#{type}');")
  end

  def self.find(id, db)
    finding_pokemon = db.execute("SELECT * FROM pokemon WHERE id = '#{id}';")
    hash = {}
    hash[:id] = finding_pokemon[0][0]
    hash[:name] = finding_pokemon[0][1]
    hash[:type] = finding_pokemon[0][2]
    hash[:hp] = finding_pokemon[0][3]
    Pokemon.new(hash)
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp = #{hp} WHERE name = '#{self.name}';")
  end

end
