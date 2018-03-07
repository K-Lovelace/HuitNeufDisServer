class CreateMarquage < Neo4j::Migrations::Base
  def up
    add_constraint :Marquage, :uuid
  end

  def down
    drop_constraint :Marquage, :uuid
  end
end
