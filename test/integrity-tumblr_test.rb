require 'test_helper'
require 'integrity/notifier/test'
require 'integrity/notifier/tumblr'

begin
  require "redgreen"
rescue LoadError
end

class IntegrityTumblrTest < Test::Unit::TestCase
  include Integrity::Notifier::Test

  def notifier
    "Tumblr"
  end

  context "A tumblr-based notifier" do
    setup { setup_database }

    should "register itself" do
      assert_equal Integrity::Notifier::Tumblr, 
                   Integrity::Notifier.available["Tumblr"]
    end

    should "have a configuration form" do
      assert_form_have_option "email",    "foo@example.org"
      assert_form_have_option "password", "secret"
    end

    [:successful, :failed, :pending].each do |status|
      should "post a notification to the tumblelog after completing a #{status} build" do
        commit = Integrity::Commit.gen(status)
        config = { :email => "foo@example.org", :password => "secret" }
        notifier = Integrity::Notifier::Tumblr.new(commit, config)

        mock(Integrity::Notifier::TumblrClient).post(config['email'], config['password'], notifier.short_message, notifier.full_message)

        notifier.deliver!
      end
    end
  end
end
