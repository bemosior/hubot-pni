# Description
#   A script to perform simplistic Participatory Narrative Inquiry.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Benjamin Mosior <bemosior@gmail.com>

Conversation = require('hubot-conversation');

module.exports = (robot) ->
  questions = [
    { text: 'When you think of the phrase “trust takes years to build but can be broken in a second,” what one event of the past seven years stands out most in your mind?' },
    { text: 'What did you learn from the events of this story?' }
    { text: 'On a scale of 1 to 5, between "far too little" and "far too much," how much trust did you see in this story?' }
  ]

  switchBoard = new Conversation(robot)

  robot.hear /hello/, (msg) ->
    referenceString = ' (Reference #' + Math.random().toString(36).substring(7) + ')'
    dialog = switchBoard.startDialog(msg, 1800000)
    qindex = 0
    proceed(msg, dialog, questions, qindex, referenceString)

proceed = (msg, dialog, questions, qindex, referenceString) ->
  sleep Math.random() * (6000 - 3000) + 3000
  msg.reply questions[qindex]['text'] + referenceString
  qindex = qindex + 1
  dialog.addChoice /(.*)/i, (msg) ->
    if qindex < questions.length
      proceed(msg, dialog, questions, qindex, referenceString)      
    else
      msg.reply 'Ok, that answers all the questions. Thanks for your time!' + referenceString

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms