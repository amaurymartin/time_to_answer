namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Setup development environment"
  task setup: :environment do
    if Rails.env.development?
      #show_spinner("Dropping database") { %x(rails db:drop) }
      show_spinner("Dropping database") { %x(rails db:drop:_unsafe) } #windows/vagrant db:drop issue (file busy)
      show_spinner("Creating database") { %x(rails db:create) }
      show_spinner("Migrating database") { %x(rails db:migrate) }
      show_spinner("Creating default admin") { %x(rails dev:add_default_admin) }
      show_spinner("Creating fake admins") { %x(rails dev:add_fake_admins) }
      show_spinner("Creating default user") { %x(rails dev:add_default_user) }
      show_spinner("Creating fake users") { %x(rails dev:add_fake_users) }
      show_spinner("Creating default subjects") { %x(rails dev:add_default_subjects) }
      show_spinner("Creating default questions and answers") { %x(rails dev:add_default_questions_and_answers) }
      #show_spinner("Seeding database") do
        #%x(rails db:seed)
      #end
    else
      puts "Not in development environment"
    end
  end

  desc "Create default admin"
  task add_default_admin: :environment do
    if Rails.env.development?
      Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
      )
    else
      puts "Not in development environment"
    end
  end

  desc "Create fake admins"
  task add_fake_admins: :environment do
    if Rails.env.development?
      9.times do
        Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD,
        )
      end
    else
      puts "Not in development environment"
    end
  end

  desc "Create default user"
  task add_default_user: :environment do
    if Rails.env.development?
      User.create!(
        email: 'user@user.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
      )
    else
      puts "Not in development environment"
    end
  end

  desc "Create fake users"
  task add_fake_users: :environment do
    if Rails.env.development?
      9.times do
        User.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD,
        )
      end
    else
      puts "Not in development environment"
    end
  end

  desc "Create default subjects"
  task add_default_subjects: :environment do
    if Rails.env.development?
      file_name = 'subjects.txt'
      file_path = File.join(DEFAULT_FILES_PATH, file_name)

      File.open(file_path, 'r').each do |line|
        Subject.create!(description: line.strip)
      end
    else
      puts "Not in development environment"
    end
  end

  desc "Create default questions and answers"
  task add_default_questions_and_answers: :environment do
    if Rails.env.development?
      Subject.all.each do |subject|
        rand(4..20).times do |i|
          params = create_question_params(subject, create_answers_attr)
          Question.create!(params)
        end
      end
    else
      puts "Not in development environment"
    end
  end

  private

  def create_answers_attr()
    answers_attributes = []
    5.times do |i|
      answers_attributes.push({
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.sentence}",
        correct: false
      })
    end
    answers_attributes[rand(answers_attributes.size)][:correct] = true
    answers_attributes
  end

  def create_question_params(subject = Subject.all.sample, answers_attributes = [])
    question_params = {
      description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
      subject: subject,
      answers_attributes: answers_attributes
    }
  end

  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
