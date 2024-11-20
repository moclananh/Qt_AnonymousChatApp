function calculateDuration(durationInMinutes) {
    var now = new Date()
    var fetchedTime = convertToGMT7(durationInMinutes)
    var diffMs = fetchedTime - now
    var diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))
    var diffHours = Math.floor(
                (diffMs % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    var diffMinutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60))

    // Build the result string conditionally
    var result = "Expires in: "
    if (diffDays > 0)
        result += diffDays + " days "
    if (diffHours > 0)
        result += diffHours + " hours "
    if (diffMinutes > 0 || result === "Expires in: ")
        result += diffMinutes + " minutes"

    return result.trim() + " left"
}

// fn caculate time display
function formatTimeDifference(createdAt, latestMsContent, latestMsTime) {
    var fetchedTime
    var timeString

    if (latestMsContent === "") {
        latestMsContent = "Group just created"
        fetchedTime = convertToGMT7(createdAt)
    } else {
        fetchedTime = convertToGMT7(latestMsTime)
    }

    var currentTime = new Date()
    var timeDifference = Math.floor((currentTime - fetchedTime) / 1000)

    if (timeDifference < 60) {
        timeString = timeDifference + " seconds ago"
    } else if (timeDifference < 3600) {
        timeString = Math.floor(timeDifference / 60) + " minutes ago"
    } else if (timeDifference < 86400) {
        timeString = Math.floor(timeDifference / 3600) + " hours ago"
    } else {
        timeString = Math.floor(timeDifference / 86400) + " days ago"
    }

    return {
        "latestMsContent": latestMsContent,
        "timeString": timeString
    }
}

// fn convert into short time HH:MM
function formatTime(originalTimeString) {
    var fetchedTime = convertToGMT7(originalTimeString)
    // Format the time to "HH:mm"
    var formattedTime = fetchedTime.getHours().toString().padStart(
                2, '0') + ":" + fetchedTime.getMinutes().toString(
                ).padStart(2, '0')

    return formattedTime
}

//function convert time to GMT+7
function convertToGMT7(time) {
    var originalTime = new Date(time)
    var fetchedTime = new Date(originalTime.getTime() + 7 * 60 * 60 * 1000)

    return fetchedTime
}

//fn generate uuid
function uuidv4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g,
                                                          function (c) {
                                                              var r = Math.random(
                                                                          ) * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8)
                                                              return v.toString(
                                                                          16)
                                                          })
}

