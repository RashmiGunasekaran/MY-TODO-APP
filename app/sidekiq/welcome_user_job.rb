class WelcomeUserJob
  include Sidekiq::Job

  def perform(*args)
    puts "Hello #{user},Happy to welcome you here."
  end
end
