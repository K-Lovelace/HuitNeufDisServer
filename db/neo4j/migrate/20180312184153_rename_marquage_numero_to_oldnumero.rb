class RenameMarquageNumeroToOldnumero < Neo4j::Migrations::Base
  def up
    rename_property :Marquage, :numero, :old_numero
  end

  def down
    raise Neo4j::IrreversibleMigration
  end
end
