# setup plugins to load
if not localStorage["version"]?
	localStorage["version"] ="google"
	window.location.reload()

enterprise.angular.dependency = []

define('config', ()->
	config = {}
	config.appName = 'Forum'
	config.plugins = 
		account: 'app/plugins/account'
		todo: 'app/plugins/todo'
		document : 'core/plugins/document'
		user : 'core/plugins/user'
		workspace : 'core/plugins/workspace'

	config
)

enterprise.load_plugins()

Nimbus.Auth.setup 
	'GDrive':
		'app_id' : '696230129324'
		'key': '696230129324-k4g89ugcu02k5obu9hs1u5tp3e54n02u.apps.googleusercontent.com',
		"scope": "openid https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/gmail.compose https://www.googleapis.com/auth/gmail.modify https://apps-apis.google.com/a/feeds/domain/"
		# "app_name": "enterprise"
	"app_name": "forum"
	'synchronous' : false

# callback for loading
Nimbus.Auth.authorized_callback = ()->
	if Nimbus.Auth.authorized()
		$("#login_buttons").addClass("redirect")

enterprise.ready(()->
	if Nimbus.Auth.authorized()
		enterprise.init(()->
			# remove indicator
			$('#loading').addClass('loaded')  
			$("#login_buttons").removeClass("redirect")
		)
	return
)

$(document).ready(()->
	
	$('#google_login').on('click',(evt)->
		 
		if not (localStorage["version"] is "google")
			localStorage["version"] = "google"
			window.location.reload()
		
		Nimbus.Auth.authorize('GDrive')
	)

	$('.logout_btn').on('click', (evt)->
		enterprise.logout()
		location.reload()
	)
	return
)

