const blessed = require('blessed')
const Magellan = require('./magellan_lib')

// // // //
// Global Variable Definitions

// Stores selectedDir for Magellan crawl
let selectedDir = null

// Color definitions
// Used for text and background colors
// in blessed components
const Colors = {
  blue: '#167bac',
  green: '#36a861',
  white: '#f3f3f3'
}

// Messages
// Stores string literals used to populate the InfoBox prompt
const Messages = {
  default:          'Command Line Utility',
  selectDirectory:  'Use "Enter" key to set the current directory. \nUse "R" key to run Magellan against the current directory.',
  running:          'Magellan is working...',
  done:             'Magellan is finished - press the "ESC" key to exit.'
}

// // // //

// Create a screen object.
const screen = blessed.screen({
  smartCSR: true,
  warnings: true
})

// Sets Screen Title
screen.title = 'Magellan CLI'

// // // //

// HeaderBox Definition
// Used to add the 'MAGELLAN' header to the application
// Always present (parent == screen)
const HeaderBox = blessed.text({
  parent: screen,
  top: 5,
  left: 'center',
  align: 'center',
  content: 'M A G E L L A N'
})

// InfoBox Definition
// Used to present instructions to the end-user
// Always present (parent == screen)
const InfoBox = blessed.text({
  parent: screen,
  top: 10,
  left: 'center',
  align: 'center',
  content: 'Command Line Utility'
})

// // // //

// HomeBox Definition
// Displayed when app starts
const HomeBox = blessed.box({
  top: 15,
  left: 'center',
  width: '50%',
  height: '50%',
  content: 'Press "Enter" key to begin or "ESC" key to exit.',
  tags: true,
  align: 'center',
  border: {
    type: 'line'
  },
  style: {
    fg: Colors.white,
    bg: Colors.blue,
    border: {
      fg: '#f0f0f0'
    }
  }
})

// // // //

// FileManager definition
// Used to pick a directory for the Magellan script
const fileManager = blessed.filemanager({
  parent: screen,
  border: 'line',
  style: {
    selected: {
      bg: Colors.blue
    }
  },
  height: 'half',
  width: 'half',
  top: 15,
  left: 'center',
  label: ' {blue-fg}%path{/blue-fg} ',
  cwd: process.env.HOME,
  keys: true,
  vi: true,
  scrollbar: {
    bg: 'white',
    ch: ' '
  }
})

// // // //

// ConfirmPrompt Definition
// Used to decide wether or not to run Magellan
// against the current directory
const ConfirmPrompt = blessed.box({
  parent: screen,
  border: 'line',
  height: 'half',
  width: 'half',
  top: 'center',
  left: 'center',
  align: 'center',
  hidden: true,
  style: {
    bg: Colors.blue
  },
})

// // // //
// Screen Events

// Screen-level key events (global)
// Quit on Escape, q, or Control-C.
screen.key(['escape', 'q', 'C-c'], (ch, key) => {
  return process.exit(0)
})

// // // //
// HomeBox Events

// Application Entrypoint ('Press Enter to begin...')
HomeBox.key('enter', (ch, key) => {

  // Hides HomeBox
  HomeBox.hide()

  // Shows FileManager
  fileManager.show()
  fileManager.refresh()

  // Updates InfoBox to display FileManager instructions
  InfoBox.setContent(Messages.selectDirectory)

  // Focus FileManager
  fileManager.focus()

  // Re-Render Screen
  return screen.render()

})

// // // //
// FileManager Events

// Listener for `cd` event in FileManager
// Assigns the selected directory to the `selectedDir` variable
fileManager.on('cd', (currentDir) => { selectedDir = currentDir })

// FileManager 'run' commadn
fileManager.key(['r'], (ch, key) => {

  // If a directory has been selected
  // Confirm whether or not to run Magellan
  if (selectedDir) {

    // Hide FileManager
    fileManager.hide()

    // Shows ConfirmPrompt
    ConfirmPrompt.show()

    // Sets ConfirmPrompt content
    ConfirmPrompt.setContent(`RUN MAGELLAN IN ${selectedDir} ? Y or N`)

    // Focus ConfirmPrompt
    ConfirmPrompt.focus()

    // Re-Render Screen
    return screen.render()
  }

})

// // // //
// ConfirmPrompt Events

// ConfirmPrompt - Confirm (y) callback
ConfirmPrompt.key(['y'], (ch, key) => {

  // Short Circuits if there is no selected directory
  if (!selectedDir) return

  // Hides ConfirmPrompt
  ConfirmPrompt.hide()

  // Show 'Working...' messsage in InfoBox
  InfoBox.setContent(Messages.running)
  screen.render() // Re-render screen

  // Runs the Magellan.buildGraph() method
  // Returns a Promise
  Magellan.buildGraph(selectedDir).then(() => {

    // Displays 'Magellan is done' message
    InfoBox.setContent(Messages.done)
    return screen.render() // Re-render screen

  })

})

// ConfirmPrompt - Deny (n) callback
ConfirmPrompt.key(['n'], (ch, key) => {

  // Hides ConfirmPrompt
  ConfirmPrompt.hide()

  // Show and Focus FileManager
  fileManager.show()
  fileManager.focus()

  // Re-Render Screen
  return screen.render()

})

// // // //
// Starts the Application

// Hides FileManager by default
fileManager.hide()

// Append HomeBox to the screen.
screen.append(HomeBox)

// Focus our element.
HomeBox.focus()

// Render the screen.
screen.render()
