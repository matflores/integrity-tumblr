require 'integrity'
require File.dirname(__FILE__) + '/tumblr_client.rb'

module Integrity
  class Notifier
    class Tumblr < Notifier::Base
      attr_reader :config

      def self.to_haml
        File.read(File.dirname(__FILE__) + "/config.haml")
      end

      def deliver!
        TumblrClient.post(config['email'], config['password'], short_message, full_message)
      end

      def to_s
        'Tumblr'
      end
    end

    register Tumblr
  end
end
