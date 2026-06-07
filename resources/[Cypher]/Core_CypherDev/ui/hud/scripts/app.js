(() => {

    ESX = {};
    ESX.HUDElements = [];

    ESX.setHUDDisplay = function(opacity) {
        $('#hud').css('opacity', opacity);

    };

    ESX.insertHUDElement = function(name, index, priority, html, data) {
        ESX.HUDElements.push({
            name: name,
            index: index,
            priority: priority,
            html: html,
            data: data
        });

        ESX.HUDElements.sort((a, b) => {
            return a.index - b.index || b.priority - a.priority;
        });
    };

    ESX.updateHUDElement = function(name, data) {

        for (let i = 0; i < ESX.HUDElements.length; i++) {
            if (ESX.HUDElements[i].name == name) {
                ESX.HUDElements[i].data = data;
            }
        }

        ESX.refreshHUD();
    };

    ESX.deleteHUDElement = function(name) {
        for (let i = 0; i < ESX.HUDElements.length; i++) {
            if (ESX.HUDElements[i].name == name) {
                ESX.HUDElements.splice(i, 1);
            }
        }

        ESX.refreshHUD();
    };

    ESX.refreshHUD = function() {
        $('#hud').html('');

        for (let i = 0; i < ESX.HUDElements.length; i++) {
            let html = Mustache.render(ESX.HUDElements[i].html, ESX.HUDElements[i].data);
            $('#hud').append(html);
        }
    };

    ESX.inventoryNotification = function(add, item, count) {
        let notif = '';

        if (add) {
            notif += '+';
        } else {
            notif += '-';
        }

        notif += count + ' ' + item.label;

        let elem = $('<div>' + notif + '</div>');

        $('#inventory_notifications').append(elem);

        $(elem).delay(3000).fadeOut(1000, function() {
            elem.remove();
        });
    };

    window.onData = (data) => {
        switch (data.action) {
            case 'setHUDDisplay':
                {
                    $('#infos').css('opacity', data.opacity);
                    $('#status_list').css('opacity', data.opacity);
                    break;
                }
            case 'updateHUDElement':
                {
                    var item = data;
                    if (item.money) {
                        $("#money").text(item.money + " $");
                    }
                    if (item.bank) {
                        $("#bank").text(item.bank + " $");
                    }
                    if (item.black_money) {
                        $("#black_money").text(item.black_money + " $");
                    }
                    if (item.job) {
                        $("#job").text(item.job);
                    }
                    if (item.job2) {
                        $("#job2").text(item.job2);
                    }
                    if (item.info) {
                        $("#infotext").text(item.info);
                    }
                    break;
                }
            case 'updateStatus':
                {
                    $("#eat").width(data.eat + "%");
                    $("#drink").width(data.drink + "%");
                    break;
                }
            case 'displayLogo':
                {
                    $('#logo').css('opacity', data.opacity);
                    $('#container').css('background', data.background)
                }
        }
    };

    window.onload = function(e) {
        window.addEventListener('message', (event) => {
            onData(event.data);
        });
    };

})();

window.addEventListener('message', function(e) {
    if (e.data.action) {
        if (e.data.action == 'showPreviewImage') {
            $('#store-container').css({ 'display': "block" });
            $('#store-container').css({ 'background': 'url("' + e.data.image + '") no-repeat center' });
            $('#store-container').css({ 'background-size': 'contain' });
            //$('body').css({ 'background-color': 'rgba(0, 0, 0, 0.25)' })
        } else if (e.data.action == 'hidePreviewImage') {
            $('#store-container').css({ 'display': "none" });
        }
    }
});