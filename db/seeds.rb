# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development? and User.any?
  colors = {
    red: "b71c1c",
    pink: "880e4f",
    purple: "4a148c",
    deep_purple: "311b92",
    indigo: "1a237e",
    blue: "0d47a1",
    light_blue: "01579b",
    cyan: "006064",
    teal: "004d40",
    green: "1b5e20",
    light_green: "33691e",
    lime: "827717",
    yellow: "f57f17",
    amber: "ff6f00",
    orange: "e65100",
    deep_orange: "bf360c",
    brown: "3e2723",
    gray: "212121",
    blue_gray: "263238",
    black: "000000",
  }

  Mission.create! do |m|
    m.title = "Operation Mahjong"
    m.start = Date.today.next_occurring(:sunday) + 7.days + 20.hours
    m.creator = User.first

    zeus = m.squads.build do |s|
      s.name = "Command"
      s.color = colors[:green]
      s.slots.build name: "Zeus"
      s.slots.build name: "Co-Zeus"
    end

    platoon = m.squads.build do |s|
      s.name = "Basilisk"
      s.parent = zeus
      s.color = colors[:light_blue]
      s.slots.build name: "Platoon Leader"
      s.slots.build name: "Platoon Medic"
    end

    [["Adder", :red], ["Boa", :blue], ["Cobra", :teal]].each do |name, color|
      m.squads.build do |s|
        s.name = name
        s.parent = platoon
        s.color = colors[color]
        s.slots.build name: "Squad Leader"
        s.slots.build name: "Combat Medic"
        s.slots.build name: "Autorifleman"
        s.slots.build name: "Grenadier"
        s.slots.build name: "Team Leader"
        s.slots.build name: "Marksman"
        s.slots.build name: "Autorifleman"
        s.slots.build name: "Rifleman (RPG)"
      end
    end

    viper = m.squads.build do |s|
      s.name = "Viper"
      s.parent = platoon
      s.color = colors[:black]
      s.slots.build name: "Cell Leader"
      s.slots.build name: "Combat Medic"
      s.slots.build name: "Team Leader"
      s.slots.build name: "Autorifleman"
      s.slots.build name: "Sharpshooter"
      s.slots.build name: "Operator"
      s.slots.build name: "JTAC"
    end

    dragon = m.squads.build do |s|
      s.name = "Dragon"
      s.parent = viper
      s.color = colors[:red]
      s.slots.build name: "Pilot"
      s.slots.build name: "Gunner"
    end
  end

  Mission.create! do |m|
    m.title = "Operation Domino"
    m.start = Date.today.next_occurring(:sunday) + 20.hours
    m.creator = User.first
    m.draft = false

    zeus = m.squads.build do |s|
      s.name = "Company HQ"
      s.color = colors[:pink]
      s.slots.build name: "Command"
      s.slots.build name: "Aide-de-Camp"
    end

    platoon = m.squads.build do |s|
      s.name = "Priest"
      s.parent = zeus
      s.color = colors[:purple]
      s.slots.build name: "Platoon Leader"
      s.slots.build name: "Platoon Medic"
      s.slots.build name: "Platoon Sgt"
      s.slots.build name: "Platoon Specialist"
    end

    [["Alpha", :red], ["Bravo", :blue]].each do |name, color|
      parent = m.squads.build do |s|
        s.name = "#{name} 1"
        s.parent = platoon
        s.color = colors[color]
        s.slots.build name: "Squad Leader"
        s.slots.build name: "Combat Medic"
        s.slots.build name: "Rifleman"
        s.slots.build name: "Rifleman"
      end

      m.squads.build do |s|
        s.name = "#{name} 2"
        s.parent = parent
        s.slots.build name: "Team Leader"
        s.slots.build name: "Autorifleman"
        s.slots.build name: "Marksman"
        s.slots.build name: "Rifleman"
      end
    end

    c1 = m.squads.build do |s|
      s.name = "Charlie 1"
      s.parent = platoon
      s.color = colors[:cyan]
      s.slots.build name: "Driver (Lead)"
    end

    c2 = m.squads.build do |s|
      s.name = "Charlie 2"
      s.parent = c1
      s.slots.build name: "Driver (2IC)"
    end

    c3 = m.squads.build do |s|
      s.name = "Charlie 3"
      s.parent = c2
      s.slots.build name: "Driver"
    end

    c4 = m.squads.build do |s|
      s.name = "Charlie 4"
      s.parent = c3
      s.slots.build name: "Driver"
    end

    m.squads.build do |s|
      s.name = "Dove"
      s.color = colors[:yellow]
      s.slots.build name: "Pilot"
      s.slots.build name: "Co-Pilot"
    end
  end

  Mission.create! do |m|
    m.title = "Operation Westerly Sandstorm"
    m.start = Date.today.next_occurring(:sunday) - 7.days + 20.hours
    m.creator = User.first
    m.draft = false
    m.public = true

    zeus = m.squads.build do |s|
      s.name = "Command"
      s.slots.build name: "Zeus"
      s.slots.build name: "Zeus Aide"
    end

    m.squads.build do |s|
      s.name = "OPFOR"
      s.slots.build name: "OPFOR"
      s.slots.build name: "OPFOR"
    end

    platoon = m.squads.build do |s|
      s.name = "Baseplate"
      s.parent = zeus
      s.slots.build name: "Platoon Leader"
      s.slots.build name: "Platoon Medic"
      s.slots.build name: "JTAC"
    end

    %w( Alpha Bravo Charlie ).each do |name|
      m.squads.build do |s|
        s.name = name
        s.parent = platoon
        s.slots.build name: "Squad Leader"
        s.slots.build name: "Squad Medic"
        s.slots.build name: "Marksman"
        s.slots.build name: "Engineer"
        s.slots.build name: "Team Leader"
        s.slots.build name: "Grenadier"
        s.slots.build name: "Machine Gunner"
        s.slots.build name: "MG Asst"
        s.slots.build name: "Rifleman"
        s.slots.build name: "Rifleman"
      end
    end

    m.squads.build do |s|
      s.name = "Pig"
      s.slots.build name: "Helicopter Pilot"
      s.slots.build name: "Door Gunner"
    end
  end
end
