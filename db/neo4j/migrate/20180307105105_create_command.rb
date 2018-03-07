class CreateCommand < Neo4j::Migrations::Base
  def up
    add_constraint :Command, :uuid
  end

  def down
    drop_constraint :Command, :uuid
  end
end
