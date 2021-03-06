(function() {
	var KEEP_ALIVE = 15 * 60 * 1000;

	window.Session = {
		onLoginSuccess: function(data) {
			var expire = data['expire_time'];
			Store.clear();
			Store.set('session-user-name', data['user_name']);
			Store.set('session-key', data['session_key']);
			Store.set('session-token', data['token']);

			if (expire)
				Store.set('session-expire-time', expire);
			Store.set('favorite', data['favorite']);

			Cookie.set('utmpkey', data['session_key'], expire ? new Date(expire * 1000) : 0, Cookie.abs('bbs'));
			Cookie.set('utmpuser', data['user_name'], expire ? new Date(expire * 1000) : 0, Cookie.abs('bbs'));

			Session.updateLastActivity();
		},

		checkLoginStatus: function() {
			App.E.fire('s:login', true);
		},

		init: function() {
			App.E.on('s:login', function(evt, loggedIn) {
				$('#nav-personal>li').each(function() {
					var t = $(this);
					t.hasClass('require-login') == loggedIn ? t.show() : t.hide();
				});
				$('#nav-profile').text(Store.get('session-user-name'));
			});
			this.checkLoginStatus();

			$('.session-logout').click(function() {
				$.post('../bbs/logout.json',
					{ token: Store.get('session-token') },
					function(data) {
						Store.clear();
						Store.set('logout', true);
						location.assign('..');
					}
				);
				return false;
			});

			App.token(function() {
				return Store.get('session-token');
			});
		},

		updateLastActivity: function() {
			Store.set('session-last-activity', (new Date()).getTime());
		}
	};
})();
