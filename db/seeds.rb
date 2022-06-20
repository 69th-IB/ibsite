# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  User.create do |u|
    u.discord_name = "darkwater"
    u.discord_uid = "120576143396044800"
    u.discord_discriminator = "2138"
  end

  mahjong = Mission.create do |m|
    m.title = "Operation Mahjong"
    m.start = Time.now
    m.creator = User.first

    zeus = m.squads.build do |s|
      s.name = "Command"
      s.slots.build name: "Zeus"
      s.slots.build name: "Co-Zeus"
    end

    platoon = m.squads.build do |s|
      s.name = "Basilisk"
      s.parent = zeus
      s.slots.build name: "Platoon Leader"
      s.slots.build name: "Platoon Medic"
    end

    %w( Adder Boa Cobra ).each do |name|
      m.squads.build do |s|
        s.name = name
        s.parent = platoon
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
      s.slots.build name: "Pilot"
      s.slots.build name: "Gunner"
    end
  end
end
