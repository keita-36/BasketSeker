10.times do
    Event.create(
        title: "ダミーイベント",
        datetime: DateTime.now,
        latitude: 35.681236,
        longitude: 139.767125,
        content: "ダミー内容",
        user_id: 1 
    )
end
