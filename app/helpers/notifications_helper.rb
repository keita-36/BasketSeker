module NotificationsHelper
    def notification_form(notification)
        #通知を送ってきたユーザーを取得
        @visitor = notification.visitor
        # notification.actionがfollowかlikeかcommentかで処理を変える
        case notification.action
        when 'user_event' then
            @event_title = notification.notifiable.event.title
            link_to(notification.visitor.name, profile_path(@visitor), class: "text-blue-500") + 'がイベント:' +  link_to("#{@event_title}", event_path(notification.notifiable.event_id), class: "text-blue-500") + 'に参加しました'
        when 'message' then
            #コメントの内容と投稿のタイトルを取得　      
            @event_title = notification.notifiable.room.event.title
            link_to(@visitor.name, profile_path(@visitor), class: "text-blue-500") + 'がイベント:' + link_to("#{@event_title}", event_path(notification.notifiable.room.event_id), class: "text-blue-500") + 'にコメントしました'
        end
    end
end
