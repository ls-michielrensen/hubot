# Description:
#   Respond to beer when it's appropriate (i.e. after 5)
#
#
# Environment:
#   HUBOT_SLACK_INCOMING_WEBHOOK

slack = require 'hubot-slack-reaction'
moment = require 'moment'
timezone = require 'moment-timezone'
truthy = [
    "Naturally. :beer:",
    "You betcha. :beer:",
    "Most assuredly. :beer:",
    "Uh huh. :beer:",
    "Sure thing. :beer:",
    "Yep. :beer:"
]
falsey = [
    "Nope. :coffee:",
    "Nah. :baby_bottle:",
    "Hell no. :tea:",
    "No way. :coffee:"
]
module.exports = (robot) ->
    robot.hear /beer/i, (msg) ->
        robot.emit 'slack.reaction',
            message: msg.message
            name: 'hourglass_flowing_sand'

        beerTime = moment(msg.message.rawMessage.ts.split(".")[0]*1000).tz(msg.message.user.slack.tz).hours()

        if beerTime > 17
            msg.send msg.random truthy
        else
            msg.send msg.random falsey
