## Installation

### Create app and push the code to cloudControl
```bash
cctrlapp APP_NAME create ruby
cctrlapp APP_NAME/default push
```

### Add required addons
```bash
cctrlapp APP_NAME/default addon.add config.free --RAILS_ENV=production
cctrlapp APP_NAME/default addon.add mongosoup.test
cctrlapp APP_NAME/default addon.add sendgrid.starter
```

### Deploy app
```bash
cctrlapp APP_NAME/default deploy
```

### Init the app when it's deployed
```bash
cctrlapp APP_NAME/default run bash
```

#### Execute in the remote console
`rake db:setup`

