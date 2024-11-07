//fn caculate duration left
function calculateDuration(durationInMinutes) {
    var now = new Date()

    var fetchedTime = new Date(new Date(durationInMinutes).getTime(
                                   ) + 7 * 60 * 60 * 1000)

    var diffMs = fetchedTime - now

    var diffMinutes = Math.floor(diffMs / 60000)

    return "Duration: " + diffMinutes + " minutes left"
}

// fn caculate time display
function formatTimeDifference(createdAt, latestMsContent, latestMsTime) {
    var fetchedTime
    var timeString

    if (latestMsContent === "") {
        latestMsContent = "Group just created"
        fetchedTime = new Date(new Date(createdAt).getTime(
                                   ) + 7 * 60 * 60 * 1000)
    } else {
        fetchedTime = new Date(new Date(latestMsTime).getTime(
                                   ) + 7 * 60 * 60 * 1000)
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
    var originalTime = new Date(originalTimeString)
    var fetchedTime = new Date(originalTime.getTime() + 7 * 60 * 60 * 1000)

    // Format the time to "HH:mm"
    var formattedTime = fetchedTime.getHours().toString().padStart(
                2, '0') + ":" + fetchedTime.getMinutes().toString(
                ).padStart(2, '0')

    return formattedTime
}
