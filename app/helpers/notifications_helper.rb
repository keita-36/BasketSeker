module NotificationsHelper
    def notification_form(notification)
        #通知を送ってきたユーザーを取得
        @visitor = notification.visitor
        # notification.actionがfollowかlikeかcommentかで処理を変える
        case notification.action
        when 'user_event' then
            @event_title = notification.notifiable.event.title
            tag.a(notification.visitor.name, href: profile_path(@visitor)) + 'が' +  tag.a("#{@event_title}", href: event_path(notification.notifiable.event_id)) + 'に参加しました'
        when 'message' then
            #コメントの内容と投稿のタイトルを取得　      
            @event_title = notification.notifiable.room.event.title
            tag.a(@visitor.name, href: profile_path(@visitor)) + 'が' + tag.a("#{@event_title}", href: event_path(notification.notifiable.room.event_id)) + 'にコメントしました'
        end
    end
end
