# frozen_string_literal: true

class BucklerGateway
  def initialize
    credentials = BucklerCredential.fetch
    @api = Buckler.build_api(credentials)
  end

  def method_missing(name, *, &)
    @api.public_send(name, *, &)
  rescue Buckler::Client::AccessDeniedError, Buckler::Client::NotFoundError => e
    BucklerCredential.clean
    BucklerLoginJob.perform_later
    raise e
  end

  def respond_to_missing?(name, include_private = false)
    @api.respond_to?(name, include_private)
  end
end
