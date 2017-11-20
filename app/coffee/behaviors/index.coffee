
# Marionette Behavior Manifest
module.exports =
  BindInputs:         require 'hn_behaviors/lib/bindInputs'
  CancelButton:       require './cancelButton'
  ClickableRelations: require './clickableRelations'
  Confirmations:      require './confirmations'
  CopyToClipboard:    require 'hn_behaviors/lib/copyToClipboard'
  DownloadFile:       require 'hn_behaviors/lib/downloadFile'
  Flashes:            require 'hn_behaviors/lib/flashes'
  FormSerialize:      require 'hn_behaviors/lib/formSerialize'
  KeyboardControls:   require './keyboardControls'
  ModelEvents:        require 'hn_behaviors/lib/modelEvents'
  SelectableChild:    require './selectableChild'
  SortableChild:      require './sortableChild'
  SortableList:       require './sortableList'
  SubmitButton:       require 'hn_behaviors/lib/submitButton'
  Tooltips:           require 'hn_behaviors/lib/tooltips'

