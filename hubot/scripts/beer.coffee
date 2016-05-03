module.exports = (robot) ->
    robot.hear /beer/i, (msg) ->
        if new Date().getHours() + 2 > 17
            robot.emit 'slack.reaction',
                message: msg.message
                name: 'beer'

            robot.emit 'slack.reaction',
                message: msg.message
                name: 'thumbsup'

            robot.emit 'slack.reaction',
                message: msg.message
                name: 'white_check_mark'
        else
            robot.emit 'slack.reaction',
                message: msg.message
                name: 'coffee'

            robot.emit 'slack.reaction',
                message: msg.message
                name: 'thumbsdown'

            robot.emit 'slack.reaction',
                message: msg.message
                name: 'no_entry_sign'
