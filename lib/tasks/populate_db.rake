namespace :populate_db do
  task all: [:users, :build_zone, :map, :generate_articles, :generate_commands]

  task :users, [] => :environment do |t, args|
    1.upto(10).each do |i|
      #create a user with minimum 90kg push and 45kg carry
      User.create({
        name: "John Doe #{i}",
        max_push: i*15+75,
        max_carry: i*5+40,
        role: 'picker'
      })
    end
  end

  task :build_zone, [] => :environment do |t, args|
    ('A'..'H').each_with_index do |allee, index|
      puts "Constructing allee #{allee}"
      porte = Porte.find_or_create_by(allee: allee) do |p|
        p.allee = allee
        p.numero = 0
        p.entry = (index % 2 == 0)
      end

      1.upto(30).each do |repere|
        puts "Armoire #{allee} #{repere}"
        armoire = Armoire.find_or_create_by(allee: allee, numero: repere)
      end
    end
  end

  task :map, [] => :environment do |t, args|
    ('A'..'H').each_with_index do |allee, index|
      puts "Mapping allee #{allee}"
      porte = Porte.find_by(allee: allee)

      1.upto(31).each do |repere|
        puts "Marquage #{allee}I#{repere}"

        marquage = Marquage.find_or_create_by(allee: allee, numero: repere)

        if porte.entry # From AI1 to AI31
            # Porte
            LeadsTo.create(from_node: porte, to_node: marquage) if repere == 1

            # Armoires
            armoire = Armoire.find_by(allee: allee, numero: repere)
            LeadsTo.create(from_node: marquage, to_node: armoire) unless armoire.nil?
            if repere > 1
              armoire = Armoire.find_by(allee: allee, numero: repere-1)
              LeadsTo.create(from_node: armoire, to_node: marquage) unless armoire.nil?
            end
        else # From AI31 to AI1
            # Porte
            LeadsTo.create(from_node: marquage, to_node: porte) if repere == 1

            # Armoires
            armoire = Armoire.find_by(allee: allee, numero: repere)
            LeadsTo.create(from_node: armoire, to_node: marquage) unless armoire.nil?
            if repere > 1
              armoire = Armoire.find_by(allee: allee, numero: repere-1)
              LeadsTo.create(from_node: marquage, to_node: armoire) unless armoire.nil?
            end
        end

        # Marquages
        if allee > 'A'
          marquage2 = Marquage.find_or_create_by(allee: (allee.ord-1).chr, numero: repere)
          LeadsTo.create(from_node: marquage2, to_node: marquage) unless repere == 1 && allee == 'B'
        end
      end
    end
  end

  task :generate_articles, [] => :environment do |t, args|
    cases_to_fill = Case.as(:c).where('NOT (c)<-[:IN]-(:Article)').order(:uuid).pluck(:c)

    while cases_to_fill.length > 0
      weight_type = rand(1..20)
      article = Article.create({
        name: "article_#{cases_to_fill.length}",
        # creates 3 times more small and light articles than heavy ones
        weight: weight_type < 15 ? rand(0.5..5.0) : rand(5.0..15.0)
      })

      puts "Article #{article.name} (remaining cases: #{cases_to_fill.length})"

      article.cases = cases_to_fill.slice!(0,4)

      article.cases.each do |c|
        c.update({
          stock: rand(1..10)
        })
      end
    end
  end

  task :generate_commands, [] => :environment do |t, args|
    1.upto(20).each do |i|
      command = Command.new

      # Get articles that are not already in command (for diversity) and order them by id (for random)
      articles = Article.as(:a).where('NOT (a)<-[:REQUIRES]-(:Command)').order(:uuid).limit(rand(3..10).to_i).pluck(:a)

      articles.each do |a|
        Requires.create({
          from_node: command,
          to_node: a,
          quantity: rand(1..5)
        })
      end
      # Save only after to trigger the lifecycle callback
      command.save
    end
  end
end