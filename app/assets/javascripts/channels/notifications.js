App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(data) {
        $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message: data.message,
            url: data.url
        },{
            type: 'info'
        });

        let drop_content = $(".dropdown-menu.notify-drop .drop-content");
        if(drop_content != null){
            drop_content.prepend(data.html);
        }
    }
});
