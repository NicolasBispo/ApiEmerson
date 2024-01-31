
namespace :dev do
    desc "Drop, create, and migrate the development database"
    task reset: [:environment] do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
    end

    desc "Execute várias tarefas na ordem desejada"
        task setup_all: [:environment] do
            Rake::Task["dev:reset"].invoke
            Rake::Task["dev:setup_users"].invoke
            Rake::Task["dev:setup_categories"].invoke
            Rake::Task["dev:setup_companies"].invoke
            Rake::Task["dev:setup_user_data"].invoke
        end
        
    desc "Setup users"
    task setup_users: [:environment] do
        unique_emails = []

        26.times do |i|
        email = nil

        # Garante que o email seja único
        loop do
            email = Faker::Internet.email
            break unless unique_emails.include?(email)
        end

        # Adicione o email ao array
        #print("Emails cadastrados:", unique_emails.inspect)
        #print("\n Email atual:", email, "\n")
        unique_emails << email

        # Crie o usuário
        is_pair = i % 2 == 0
        User.create!(email: email, password: "change123", promoter: is_pair)
        end
        User.create!(email: "adminglobal@gmail.com", password: "change123")
    end

    desc "Setup Categories"
    task setup_categories: [:environment] do

        10.times do |i|
            Category.create(
                name: Faker::Lorem.sentence
            )

        end

    end

    desc "Setup Companies"
    task setup_companies: [:environment] do
        normal_users = User.where(promoter: false)
        promoters = User.where(promoter:true)
        20.times do |i|
            Company.create!(
                name: Faker::Name.name,
                cnpj: Faker::Config.random.seed,
                user: normal_users.all.sample,
                category: Category.all.sample)
        end

        10.times do |i|
            
            c = CompanyContract.create!(
                name: "Contract #{i} global", 
                text: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
                start_date: Faker::Date.forward(days: 100),
                end_date: Faker::Date.forward(days: 100),
                status: "EM ABERTO",
                company: Company.all.sample)

            3.times do |i|
                c.user << promoters.all.sample
            end
        end

        20.times do |i|
            Campaign.create!(
                name: Faker::Lorem.sentence,
                company: Company.all.sample
            )
        end

        
        Campaign.all.each do |campaign|
            
            3.times do |i|
                CampaignDescriptor.create!(
                name: Faker::Lorem.word,
                value: Faker::Lorem.word,
                campaign: campaign
                )
                campaign_contract = CampaignContract.create!(
                    name: Faker::Lorem.sentence,
                    text: Faker::Lorem.paragraph(sentence_count: 4),
                    start_date: Faker::Date.forward(days: 100),
                    end_date: Faker::Date.forward(days: 100),
                    status: "Andamento",
                    campaign_id: campaign.id
                )
                campaign_contract.users << promoters.all.sample
            end
        end
    end

    desc "Setup User data"
    task setup_user_data: [:environment] do
        User.all.each do |user|
            if user.promoter
                3.times do |i|
                    social_link = SocialLink.create!(
                        name: Faker::Company.name,
                        url: "http://example.com",
                        user: user
                    )
                    3.times do |j|
                        SocialMediaDescriptor.create!(
                            name: Faker::Lorem.word,
                            value: Faker::Lorem.word,
                            social_link: social_link
                        )
                    end
                end
            end
        end
    end
    
  end