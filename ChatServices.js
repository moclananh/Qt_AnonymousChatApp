//fn fetch data
function fetchData(url, method, headers, callback, data = null) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log('HEADERS_RECEIVED')
        } else if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log('DONE')
            if (xhr.status == 200) {
                callback(xhr.responseText.toString())
            } else {
                console.debug("Response eror: ", xhr.status)
                console.debug("Response: ", xhr.responseText)
                callback(null)
            }
        }
    }

    xhr.open(method, url)
    if (headers !== null && headers !== undefined) {
        for (var headerEntry in headers) {
            xhr.setRequestHeader(headerEntry, headers[headerEntry])
        }
    }
    console.debug("Call request: ", url, ", method: ", method)
    console.debug("xhr: ", xhr.toString())
    // Set header for POST requests with JSON data
    if (method === "POST" && data) {
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.send(JSON.stringify(data))
    } else {
        xhr.send()
    }
}

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
