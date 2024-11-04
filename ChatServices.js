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

function calculateDuration(durationInMinutes) {
    var now = new Date()
    console.log("Date time now: " + now)

    var fetchedTime = new Date(new Date(durationInMinutes).getTime(
                                   ) + 7 * 60 * 60 * 1000)

    console.log("FetchedTime time: " + fetchedTime)

    var diffMs = fetchedTime - now
    console.log("Diff: " + diffMs)
    var diffMinutes = Math.floor(diffMs / 60000)

    return "Duration: " + diffMinutes + " minutes left"
}
