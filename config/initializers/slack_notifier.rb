module SlackNotifier
  CLIENT = Slack::Notifier.new ENV['WEBHOOK_URL']
end