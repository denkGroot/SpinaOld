puts "Seeding #{__FILE__} from Spina"

Spina::User.destroy_all
Spina::User.create name: "Bram", email: "bram@denkgroot.com", password: "spina", password_confirmation: "spina", admin: true

Spina::Account.destroy_all
Spina::Account.create name: "Website"
