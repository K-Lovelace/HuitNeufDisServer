class CreateArticle < Neo4j::Migrations::Base
  def up
    add_constraint :Article, :uuid
  end

  def down
    drop_constraint :Article, :uuid
  end
end
