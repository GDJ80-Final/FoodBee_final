<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Stopwatch Test</title>
</head>
<body>
    <div id="stopwatch">경과 시간: 00시간 00분 00초</div>
    <button id="startButton">출근</button>

    <script>
        let stopwatchInterval;
        let elapsedTime = 0;

        document.getElementById('startButton').onclick = function() {
            elapsedTime = 0;
            startStopwatch();
        };

        function startStopwatch() {
            stopwatchInterval = setInterval(() => {
                elapsedTime += 1000;
                updateStopwatchDisplay();
            }, 1000);
        }

        function updateStopwatchDisplay() {
            const hours = Math.floor((elapsedTime / (1000 * 60 * 60)) % 24);
            const minutes = Math.floor((elapsedTime / (1000 * 60)) % 60);
            const seconds = Math.floor((elapsedTime / 1000) % 60);

            const formattedHours = String(hours).padStart(2, '0');
            const formattedMinutes = String(minutes).padStart(2, '0');
            const formattedSeconds = String(seconds).padStart(2, '0');

            document.getElementById('stopwatch').innerText = `경과 시간: ${formattedHours}시간 ${formattedMinutes}분 ${formattedSeconds}초`;
        }
    </script>
</body>
</html>