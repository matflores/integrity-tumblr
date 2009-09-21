require 'httparty'

module Integrity
  class Notifier
    class TumblrClient
      def self.post(email, password, title, body)
        HTTParty.post 'http://www.tumblr.com/api/write', :body => { :email => email, 
                                                                    :password => password,
                                                                    :type => 'regular',
                                                                    :title => title,
                                                                    :body => body,
                                                                    :generator => 'integrity-tumblr notifier' }
      end
    end
  end
end
