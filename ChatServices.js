function fetchData(url, method, callback, data = null) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log('HEADERS_RECEIVED')
        } else if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log('DONE')
            if (xhr.status == 200) {
                callback(xhr.responseText.toString())
            } else {
                callback(null)
            }
        }
    }

    xhr.open(method, url)

    // Set header for POST requests with JSON data
    if (method === "POST" && data) {
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.send(JSON.stringify(data))
    } else {
        xhr.send()
    }
}
