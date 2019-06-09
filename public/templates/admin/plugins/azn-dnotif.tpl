<form role="form" class="azn-dnotif-settings">
	<div class="row">
		<div class="col-sm-2 col-xs-12 settings-header">[[azn-dnotif:webhook]]</div>
		<div class="col-sm-10 col-xs-12">
			<div class="form-group">
				<label for="webhookURL">[[azn-dnotif:webhook-url]]</label>
				<input type="text" class="form-control" id="webhookURL" name="webhookURL" />
				<p class="help-block">[[azn-dnotif:webhook-help]]</p>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-2 col-xs-12 settings-header">[[azn-dnotif:notification]]</div>
		<div class="col-sm-10 col-xs-12">
			<div class="form-group">
				<label for="maxLength">[[azn-dnotif:notification-max-length]]</label>
				<input type="number" class="form-control" id="maxLength" name="maxLength" min="1" max="1024" value="100" />
				<p class="help-block">[[azn-dnotif:notification-max-length-help]]</p>
			</div>
			<div class="form-group">
				<label for="postCategories">[[azn-dnotif:post-categories]]</label>
				<select class="form-control" id="postCategories" name="postCategories" size="10" multiple></select>
			</div>
			<div class="checkbox">
				<label for="topicsOnly" class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" id="topicsOnly" name="topicsOnly" />
					<span class="mdl-switch__label">[[azn-dnotif:topics-only]]</span>
				</label>
			</div>
			<div class="form-group">
				<label for="messageContent">[[azn-dnotif:message]] <small>([[azn-dnotif:message-sidenote]])</small></label>
				<textarea class="form-control" id="messageContent" name="messageContent" maxlength="512"></textarea>
				<p class="help-block">[[azn-dnotif:message-help]]</p>
			</div>
		</div>
	</div>
</form>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	<i class="material-icons">save</i>
</button>

<script>
	$(document).ready(function() {
		socket.emit('categories.get', function(err, data) {
			categories = data;
			for (var i = 0; i < categories.length; ++i) {
				$('#postCategories').append('<option value=' + categories[i].cid + '>' + categories[i].name + '</option>');
			}
		});
	});

	require(['settings'], function(Settings) {
		Settings.load('azn-dnotif', $('.azn-dnotif-settings'));

		$('#save').on('click', function() {
			Settings.save('azn-dnotif', $('.azn-dnotif-settings'), function() {
				app.alert({
					type: 'success',
					alert_id: 'azn-notif-saved',
					title: 'Settings Saved',
					message: 'Please reload your NodeBB to apply these settings',
					clickfn: function() {
						socket.emit('admin.reload');
					}
				});
			});
		});
	});
</script>
