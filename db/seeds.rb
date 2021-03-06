# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             post_id: 10)

Post.create!(name: "北海道",
            latitude: 43.0686606,
            longitude: 141.3503005)
Post.create!(name: "青森県",
            latitude: 40.8293776,
            longitude: 140.732115)
Post.create!(name: "岩手県",
            latitude: 39.7019839,
            longitude: 141.1352244)
Post.create!(name: "宮城県",
            latitude: 38.2602368,
            longitude: 140.8821118)
Post.create!(name: "秋田県",
            latitude: 39.7161196,
            longitude: 140.1258929)
Post.create!(name: "山形県",
            latitude: 38.2515143,
            longitude: 140.3259046)
Post.create!(name: "福島県",
            latitude: 37.3981998,
            longitude: 140.3859404)
Post.create!(name: "茨城県",
            latitude: 36.3707594,
            longitude: 140.4741193)
Post.create!(name: "栃木県",
            latitude: 36.5593052,
            longitude: 139.8961639)
Post.create!(name: "群馬県",
            latitude: 36.3841044,
            longitude: 139.0717359)
Post.create!(name: "埼玉県",
            latitude: 35.9144901,
            longitude: 139.6166235)
Post.create!(name: "千葉県",
            latitude: 35.609488,
            longitude: 140.1142759)
Post.create!(name: "東京都",
            latitude: 35.6851333,
            longitude: 139.7523673)
Post.create!(name: "神奈川県",
            latitude: 35.4659854,
            longitude: 139.6198733)
Post.create!(name: "新潟県",
            latitude: 37.912043,
            longitude: 139.0595863)
Post.create!(name: "富山県",
            latitude: 37.912043,
            longitude: 139.0595863)
Post.create!(name: "石川県",
            latitude: 36.7018311,
            longitude: 137.2104371)
Post.create!(name: "福井県",
            latitude: 36.0616547,
            longitude: 136.2213569)
Post.create!(name: "山梨県",
            latitude: 35.6652648,
            longitude: 138.5683201)
Post.create!(name: "長野県",
            latitude: 36.6435075,
            longitude: 138.1855153)
Post.create!(name: "岐阜県",
            latitude: 36.6435075,
            longitude: 138.1855153)
Post.create!(name: "静岡県",
            latitude: 34.9726399,
            longitude: 138.3976153)
Post.create!(name: "愛知県",
            latitude: 35.1700387,
            longitude: 136.8818252)
Post.create!(name: "三重県",
            latitude: 34.7336908,
            longitude: 136.510723)
Post.create!(name: "滋賀県",
            latitude: 35.0208562,
            longitude: 135.8578349)
Post.create!(name: "京都府",
            latitude: 34.9858492,
            longitude: 135.7543894)
Post.create!(name: "大阪府",
            latitude: 34.7032156,
            longitude: 135.4888876)
Post.create!(name: "兵庫県",
            latitude: 34.6813414,
            longitude: 135.171535)
Post.create!(name: "奈良県",
            latitude: 34.6797446,
            longitude: 135.8187477)
Post.create!(name: "和歌山県",
            latitude: 34.231035,
            longitude: 135.191433)
Post.create!(name: "鳥取県",
            latitude: 35.492737,
            longitude: 134.2258428)
Post.create!(name: "島根県",
            latitude: 35.4640299,
            longitude: 133.0519913)
Post.create!(name: "岡山県",
            latitude: 34.6653844,
            longitude: 133.9174975)
Post.create!(name: "広島県",
            latitude: 34.3976714,
            longitude: 132.4731899)
Post.create!(name: "山口県",
            latitude: 34.1727991,
            longitude: 131.4109468)
Post.create!(name: "徳島県",
            latitude: 34.0741632,
            longitude: 134.5496055)
Post.create!(name: "香川県",
            latitude: 35.3552975,
            longitude: 139.400173)
Post.create!(name: "愛媛県",
            latitude: 33.8356154,
            longitude: 132.7496031)
Post.create!(name: "高知県",
            latitude: 33.5656939,
            longitude: 133.543495)
Post.create!(name: "福岡県",
            latitude: 36.707846,
            longitude: 136.9384026)
Post.create!(name: "佐賀県",
            latitude: 33.2634182,
            longitude: 130.2969462)
Post.create!(name: "長崎県",
            latitude: 32.7521087,
            longitude: 129.8674357)
Post.create!(name: "熊本県",
            latitude: 32.7899813,
            longitude: 130.6879413)
Post.create!(name: "大分県",
            latitude: 33.2323571,
            longitude: 131.60504)
Post.create!(name: "宮崎県",
            latitude: 31.9157176,
            longitude: 131.4300324)
Post.create!(name: "鹿児島県",
            latitude: 31.5836892,
            longitude: 130.534305)
Post.create!(name: "沖縄県",
            latitude: 26.2060808,
            longitude: 127.6477009)

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               post_id: Random.rand(1 .. 47),
               password: password,
               password_confirmation: password)
end