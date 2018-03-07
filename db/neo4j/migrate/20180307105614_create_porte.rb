class CreatePorte < Neo4j::Migrations::Base
  def up
    add_constraint :Porte, :uuid
  end

  def down
    drop_constraint :Porte, :uuid
  end
end
