function fetchData(url, callback) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED')
        } else if (xhr.readyState === XMLHttpRequest.DONE) {
            print('DONE')
            if (xhr.status == 200) {
                //console.log("resource found" + xhr.responseText.toString())
                callback(xhr.responseText.toString())
            } else {
                callback(null)
            }
        }
    }
    xhr.open("GET", url)
    xhr.send()
}
