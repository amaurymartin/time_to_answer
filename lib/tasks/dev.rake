namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Setup development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping database") { %x(rails db:drop) }
      show_spinner("Creating database") { %x(rails db:create) }
      show_spinner("Migrating database") { %x(rails db:migrate) }
      show_spinner("Creating default admin") { %x(rails dev:add_default_admin) }
      show_spinner("Creating default user") { %x(rails dev:add_default_user) }
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

  private

  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
