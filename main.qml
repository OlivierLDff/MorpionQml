import QtQuick 2.12
import QtQuick.Window 2.12

Window
{
    id: game
    visible: true
    width: 640
    height: 480
    title: qsTr("Morpion")

    readonly property int emptyState: 0
    readonly property int p1State: 1
    readonly property int p2State: 2

    property var caseState:
    [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
    ];
    property bool evalutateCaseState: false

    property int p1Score: 0
    property int p2Score: 0

    property int lastPlayerVictory

    property bool shouldClickRestart
    property bool atLeastOneZero: true

    function evaluateVictory()
    {
        // Check columns
        for (var x = 0; x < 3; x++)
        {
            if(game.caseState[x][0] && (game.caseState[x][0] === game.caseState[x][1]) && (game.caseState[x][1] === game.caseState[x][2]))
            {
                if(game.caseState[x][0] === 1)
                {
                    lastPlayerVictory = 1
                    ++p1Score;
                }

                if(game.caseState[x][0] === 2)
                {
                    lastPlayerVictory = 2
                    ++p2Score;
                }

                game.shouldClickRestart = true
                return
            }
        }

        // ) Check rows
        for (var y = 0; y < 3; y++)
        {
            if(game.caseState[0][y] && (game.caseState[0][y] === game.caseState[1][y]) && (game.caseState[1][y] === game.caseState[2][y]))
            {
                if(game.caseState[0][y] === 1)
                {
                    lastPlayerVictory = 1
                    ++p1Score;
                }

                if(game.caseState[0][y] === 2)
                {
                    lastPlayerVictory = 2
                    ++p2Score;
                }

                game.shouldClickRestart = true
                return
            }
        }

        // Check diag
        if(game.caseState[0][0] && (game.caseState[0][0] === game.caseState[1][1]) && (game.caseState[1][1] === game.caseState[2][2]))
        {
            if(game.caseState[0][0] === 1)
            {
                lastPlayerVictory = 1
                ++p1Score;
            }

            if(game.caseState[0][0] === 2)
            {
                lastPlayerVictory = 2
                ++p2Score;
            }

            game.shouldClickRestart = true
            return
        }

        if(game.caseState[0][2] && (game.caseState[0][2] === game.caseState[1][1]) && (game.caseState[1][1] === game.caseState[2][0]))
        {
            if(game.caseState[0][2] === 1)
            {
                lastPlayerVictory = 1
                ++p1Score;
            }

            if(game.caseState[0][2] === 2)
            {
                lastPlayerVictory = 2
                ++p2Score;
            }

            game.shouldClickRestart = true
            return
        }

        // Check level is complete
        var atLeastOneZero = false
        for (var i = 0; i < 3; i++)
        {
            for (var j = 0; j < 3; j++)
            {
                if(game.caseState[i][j] === 0)
                {
                    atLeastOneZero = true
                    break
                }
            }
        }

        if(!atLeastOneZero)
        {
            game.shouldClickRestart = true
            game.atLeastOneZero = false
        }
    }

    Text
    {
        id: infoText
        text: !game.atLeastOneZero ? "Match nul" : game.shouldClickRestart ? "Bravo au joueur " + game.lastPlayerVictory.toString() + ". Appuyez sur recommencer" : "C'est le tour du joueur " + (game.currentPlayer+1).toString()
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: playZone.top
        anchors.bottomMargin: 10
    }

    // 0 mean p1, 1 mean p2
    property int currentPlayer: 0

    Rectangle
    {
        id: playZone

        readonly property int caseSize: 100

        width: playZone.caseSize*3
        height: playZone.caseSize*3
        border.width: 2
        border.color: "black"
        anchors.centerIn: parent

        Rectangle
        {
            x: parent.width/3
            width: 2
            height: parent.height
            color: "black"
        }

        Rectangle
        {
            x: parent.width*2/3
            width: 2
            height: parent.height
            color: "black"
        }

        Rectangle
        {
            y: parent.height/3
            width: parent.width
            height: 2
            color: "black"
        }

        Rectangle
        {
            y: parent.height*2/3
            width: parent.width
            height: 2
            color: "black"
        }

        Case
        {
            size: playZone.caseSize
            onEvaluateChanged: state = game.caseState[0][0]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width/3
            onEvaluateChanged: state = game.caseState[1][0]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width*2/3
            onEvaluateChanged: state = game.caseState[2][0]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            y:  parent.height/3
            onEvaluateChanged: state = game.caseState[0][1]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width/3
            y:  parent.height/3
            onEvaluateChanged: state = game.caseState[1][1]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width*2/3
            y:  parent.height/3
            onEvaluateChanged: state = game.caseState[2][1]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            y:  parent.height*2/3
            onEvaluateChanged: state = game.caseState[0][2]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width/3
            y:  parent.height*2/3
            onEvaluateChanged: state = game.caseState[1][2]
            evaluate: game.evalutateCaseState
        }

        Case
        {
            size: playZone.caseSize
            x: parent.width*2/3
            y:  parent.height*2/3
            onEvaluateChanged: state = game.caseState[2][2]
            evaluate: game.evalutateCaseState
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if(game.shouldClickRestart)
                    return

                console.log("click x : " + mouse.x + ", y: " + mouse.y)

                var xCoord = Math.floor((mouse.x*3)/playZone.width)
                var yCoord = Math.floor((mouse.y*3)/playZone.height)

                console.log("coord: {" + xCoord + "," + yCoord + "}")

                var currentCaseState = game.caseState[xCoord][yCoord]

                if(currentCaseState)
                {
                    console.log("Error: Il y a déjà quelque chose dans cette case")
                }
                else
                {
                    game.caseState[xCoord][yCoord] = game.currentPlayer+1
                    game.currentPlayer = game.currentPlayer ? 0 : 1
                    game.evalutateCaseState = true
                    game.evalutateCaseState = false

                    game.evaluateVictory()
                }
            }
        }
    }

    Text
    {
        anchors.left: playZone.left
        anchors.top: playZone.bottom
        anchors.topMargin: 10

        text: "Score : P1 : " + game.p1Score + ", P2 : " + game.p2Score
    }

    Rectangle
    {
        anchors.right: playZone.right
        anchors.top: playZone.bottom
        anchors.topMargin: 10

        border.width: 1
        border.color: "black"

        width: 100
        height: 30

        Text {
            anchors.centerIn: parent
            text: qsTr("Recommencer")
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                console.log("restart the game")
                game.currentPlayer = 0

                caseState =
                [
                        [0, 0, 0],
                        [0, 0, 0],
                        [0, 0, 0],
                ];
                game.evalutateCaseState = true
                game.evalutateCaseState = false

                game.shouldClickRestart = false
                game.atLeastOneZero = true

            }
        }
    }
}
