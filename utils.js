var groupMessages = {}

// Global object to store group messages
function loadMessage(c_user_code, groupId, currentPage) {
    let headers = {}
    if (c_user_code) {
        headers = {
            "x-user-code": c_user_code
        }
    }

    console.log("Group Id received: " + groupId)

    if (!groupMessages[groupId]) {
        groupMessages[groupId] = {
            "messages": [],
            "currentPage": 1
        }
    }

    var groupData = groupMessages[groupId]
    var requestUrl = `http://127.0.0.1:8080/groups/${groupId}/messages?page=${currentPage}&limit=15&created_at_sort=DESC`
    networkManagerLoadMessage.fetchData(requestUrl, "GET", headers)
}

function refreshMessagesForGroup(groupId, lsViewId) {
    if (groupMessages[groupId]) {
        const messages = groupMessages[groupId].messages

        lsViewId.model.clear()
        for (var i = 0; i < messages.length; i++) {
            lsViewId.model.append(messages[i])
        }

        if (messages.length > 0) {
            lsViewId.currentIndex = messages.length - 1
            lsViewId.positionViewAtIndex(lsViewId.currentIndex, ListView.End)
        }
    }
}
