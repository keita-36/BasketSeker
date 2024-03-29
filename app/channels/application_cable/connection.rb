module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        if verified_user = User.find_by(id: cookies.signed[:user_id])
          logger.debug "User ID from cookies: #{cookies.signed[:user_id]}"
          verified_user
        else
          reject_unauthorized_connection
          logger.debug "User ID from uncookies: #{cookies.signed[:user_id]}"
        end
      end
  end
end
