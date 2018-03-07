namespace :populate_db do
  task :users, [] => :environment do |t, args|
    1.upto(10).each do |i|
      User.create({
        name: "John Doe #{i}",
        max_push: i*10,
        max_carry: i*2,
        role: 'picker'
      })
    end
  end

  task :build_zone, [] => :environment do |t, args|
    ('A'..'H').each_with_index do |allee, index|
      puts "Constructing allee #{allee}"
      porte = Porte.find_or_create_by(allee: allee) do |p|
        p.allee = allee
        p.entry = (index % 2 == 0)
      end

      1.upto(30).each do |repere|
        puts "Armoire #{allee} #{repere}"
        armoire = Armoire.find_or_create_by(allee: allee, numero: repere)
      end
    end
  end

  task :map, [] => :environment do |t, args|
    ('A'..'G').each_with_index do |allee, index|
      puts "Mapping allee #{allee}"
      porte = Porte.find_by(allee: allee)

      1.upto(31).each do |repere|
        puts "Marquage #{allee}I#{repere}"

        marquage = Marquage.find_or_create_by(numero: "#{allee}I#{repere}")
        # Porte
        LeadsTo.create(from_node: porte, to_node: marquage) if porte.entry && repere == 1
        LeadsTo.create(from_node: marquage, to_node: porte) if !porte.entry && repere == 1

        # Armoires
        armoire = Armoire.find_by(allee: allee, numero: repere)
        LeadsTo.create(from_node: marquage, to_node: armoire) unless armoire.nil?

        if repere > 1
          armoire = Armoire.find_by(allee: allee, numero: repere-1)
          LeadsTo.create(from_node: armoire, to_node: marquage) unless armoire.nil?
        end
        # Marquages
        if allee > 'A'
          marquage2 = Marquage.find_or_create_by(numero: "#{(allee.ord-1).chr}I#{repere}")
          LeadsTo.create(from_node: marquage2, to_node: marquage) unless repere == 1 && allee == B
        end
      end
    end
  end
end