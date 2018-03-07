class CreateLeadsTo < Neo4j::Migrations::Base
  def up
    add_constraint :LeadsTo, :uuid
  end

  def down
    drop_constraint :LeadsTo, :uuid
  end
end
