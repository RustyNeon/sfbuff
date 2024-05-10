# frozen_string_literal: true

class BucklerLoginJob < ApplicationJob
  limits_concurrency to: 1, key: 'buckler_login'
  retry_on StandardError, wait: 30.seconds, attempts: 3

  queue_as :default

  def perform
    return if BucklerCredential.read.present?

    credentials = Buckler::Login.new.execute
    BucklerCredential.store(credentials)
  end
end
