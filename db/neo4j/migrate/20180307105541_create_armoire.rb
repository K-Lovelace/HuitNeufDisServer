class CreateArmoire < Neo4j::Migrations::Base
  def up
    add_constraint :Armoire, :uuid
  end

  def down
    drop_constraint :Armoire, :uuid
  end
end
