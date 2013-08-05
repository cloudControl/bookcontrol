## Installation

### Create app on cloudControl
```bash
cctrlapp APP_NAME create ruby
cctrlapp APP_NAME/default push
cctrlapp APP_NAME/default deploy
```

### Add required addons
```bash
cctrlapp APP_NAME/default addon.add config.free --RAILS_ENV=production
cctrlapp APP_NAME/default addon.add mongosoup.test
cctrlapp APP_NAME/default addon.add sendgrid.starter
```

### Init app
```bash
cctrlapp APP_NAME/default run bash
```

#### in the remote console
`rake db:setup`

