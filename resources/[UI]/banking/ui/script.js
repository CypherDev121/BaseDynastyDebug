$(function() {
  
    $(".container").hide();
    $(".logo-rectangle").hide();

    window.addEventListener('message', function(event) {
        let data = event.data;
        console.log('Received message:', data);

        if (data.type === "ui") {
            if (data.status) {
                $(".container").fadeIn();
                $(".container").addClass('active');
                $(".logo-rectangle").fadeIn();
            } else {
                $(".container").fadeOut();
                $(".container").removeClass('active');
                $(".logo-rectangle").fadeOut();
        
                $('.modal').removeClass('active');
                $('.modal input').val('');
            }
        }

        if (data.type === "update") {
            console.log('Updating UI with:', data);
            $('.balanceText').text('$' + data.balance.toLocaleString());        
            if (data.firstName || data.lastName) {
                $('.user-name').text(data.firstName + ' ' + data.lastName);
            }
            if (data.transactions) {
                updateTransactionHistory(data.transactions);
            }
        }
    });

    function updateTransactionHistory(transactions) {
        const historyList = $('.history-list');
        historyList.empty();

        if (!transactions || transactions.length === 0) {
            historyList.append('<div class="history-item">Aucune transaction récente</div>');
            return;
        }

        transactions.forEach(function(transaction) {
            const isPositive = transaction.type === 'deposit' || 
                             (transaction.type === 'transfer' && transaction.target_identifier);
            const amount = isPositive ? '+$' + transaction.amount : '-$' + transaction.amount;
            const icon = transaction.type === 'deposit' ? 'deposit-icon.png' : 
                        transaction.type === 'withdraw' ? 'withdraw-icon.png' : 'transfer-icon.png';
            const title = transaction.type === 'deposit' ? 'DÉPÔT' : 
                         transaction.type === 'withdraw' ? 'RETRAIT' : 'TRANSFERT';

            const historyItem = $('<div>').addClass('history-item ' + transaction.type);
            const leftSection = $('<div>').addClass('history-item-left');
            const icon_img = $('<img>').attr('src', 'assets/' + icon).addClass('history-item-icon');
            const info = $('<div>').addClass('history-item-info');
            const titleSpan = $('<span>').addClass('history-item-title').text(title);
            const timeSpan = $('<span>').addClass('history-item-subtitle').text(formatTimestamp(transaction.timestamp));
            const amountSpan = $('<span>').addClass('history-item-amount').text(amount);

            info.append(titleSpan, timeSpan);
            leftSection.append(icon_img, info);
            historyItem.append(leftSection, amountSpan);
            historyList.append(historyItem);
        });
    }

    function formatTimestamp(timestamp) {
        if (!timestamp) return 'À l\'instant';
        const date = new Date(timestamp);
        const now = new Date();
        const diff = now - date;
        
        const minutes = Math.floor(diff / 60000);
        const hours = Math.floor(diff / 3600000);
        const days = Math.floor(diff / 86400000);

        if (minutes < 60) return `Il y a ${minutes} minute${minutes > 1 ? 's' : ''}`;
        if (hours < 24) return `Il y a ${hours} heure${hours > 1 ? 's' : ''}`;
        return `Il y a ${days} jour${days > 1 ? 's' : ''}`;
    }

   
    $('.action-btn.deposit').click(function() {
        $('.deposit-modal').addClass('active');
    });

    $('.action-btn.withdraw').click(function() {
        $('.withdraw-modal').addClass('active');
    });

    $('.action-btn.transfer').click(function() {
        $('.transfer-modal').addClass('active');
    });


    $('.deposit-modal .action-button').click(function() {
        const amount = parseInt($('.deposit-modal .amount-input').val());
        if (amount > 0) {
            $.post('https://banking/deposit', JSON.stringify({amount: amount}));
            $('.deposit-modal').removeClass('active');
            $('.deposit-modal input').val('');
        }
    });

    $('.withdraw-modal .action-button').click(function() {
        const amount = parseInt($('.withdraw-modal .amount-input').val());
        if (amount > 0) {
            $.post('https://banking/withdraw', JSON.stringify({amount: amount}));
            $('.withdraw-modal').removeClass('active');
            $('.withdraw-modal input').val('');
        }
    });

    $('.transfer-modal .action-button').click(function() {
        const amount = parseInt($('.transfer-modal .amount-input').val());
        const targetId = parseInt($('.transfer-modal .id-input').val());
        if (amount > 0 && targetId) {
            $.post('https://banking/transfer', JSON.stringify({
                amount: amount,
                targetId: targetId
            }));
            $('.transfer-modal').removeClass('active');
            $('.transfer-modal input').val('');
        }
    });


    $('.modal').click(function(e) {
        if (e.target === this) {
            $(this).removeClass('active');
            $(this).find('input').val('');
        }
    });

  
    $('.close-btn').click(function() {
        $(".container").fadeOut();
        $(".container").removeClass('active');
        $(".logo-rectangle").fadeOut();
        $.post('https://banking/exit', JSON.stringify({}));
    });

 
    document.addEventListener('contextmenu', function(e) {
        e.preventDefault();
    });
});
