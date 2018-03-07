class CreateCase < Neo4j::Migrations::Base
  def up
    add_constraint :Case, :uuid
  end

  def down
    drop_constraint :Case, :uuid
  end
end
