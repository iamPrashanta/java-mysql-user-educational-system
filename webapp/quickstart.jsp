<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quick Start Guide</title>
    <link rel="stylesheet" href="css/navbar.css">
    <script src="./js/nav.js"></script>
    <style>
       .Quick-Start {
           margin: auto;
           margin-top: 100px;
           padding: 20px;
           max-width: 800px;
       }

       .code-snippet-container {
           position: relative;
           overflow: auto;
           max-height: 200px;
       }

       .code-snippet {
           position: relative;
           font-family: 'Fira Code', monospace;
           font-style: italic;
           background-color: #151718;
           color: #fff;
           padding: 10px;
           border-radius: 5px;
           margin-bottom: 20px;
           margin-left: -100px;
           font-size: 16px;
           line-height: 1.5;
           text-align: left;
           white-space: pre-wrap;
           word-wrap: break-word;
           overflow: auto;
       }

       .copy-button {
           position:relative;
           background-color: #EC5E30;
           color: white;
           border: 1px solid #EC5E30;
           border-radius: 3px;
           cursor: pointer;
           font-size: 15px;
           padding: 10px 20px;
           transition: background-color 0.3s, color 0.3s;
       }

       .copy-button:hover {
           background-color: #000;
           color: #fff;
       }


    </style>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="./courses.jsp" class="link">Courses</a>
            <a href="./login.jsp" class="link login button" style="margin-top: 5px">Login</a>
            <a href="./signup.jsp" class="link login button" style="margin-top: 5px">Sign up</a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <div class="Quick-Start">
        <h1>Quick Start Guide</h1>
        
        <div>
            <h2>Step 1: Create Database</h2>
            <p>Before running the project, create a database named <strong>edu-connect-db</strong> using the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step1-code">
                CREATE DATABASE `edu-connect-db`;
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step1-code')" data-element-id="step1-code">Copy</button>
        </div>

        <div>
            <h2>Step 2: Use Database</h2>
            <p>Switch to the <strong>edu-connect-db</strong> database using the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step2-code">
                USE `edu-connect-db`;
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step2-code')" data-element-id="step2-code">Copy</button>
        </div>

        <div>
            <h2>Step 3: Create Users Table</h2>
            <p>Create the <strong>users</strong> table with the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step3-code">
                CREATE TABLE IF NOT EXISTS `users` (
                `id` int NOT NULL,
                `name` varchar(50) NOT NULL,
                `email` varchar(50) NOT NULL,
                `phone` varchar(13) NOT NULL,
                `address` varchar(200) DEFAULT NULL,
                `password` varchar(60) NOT NULL,
                PRIMARY KEY (`id`),
                UNIQUE KEY `Email_ID` (`email`)
                );
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step3-code')" data-element-id="step3-code">Copy</button>
        </div>

        <div>
            <h2>Step 4: Create Admins Table</h2>
            <p>Create the <strong>admins</strong> table with the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step4-code">
                CREATE TABLE IF NOT EXISTS `admins` (
                `admin_id` int NOT NULL,
                `name` varchar(50) NOT NULL,
                `email` varchar(50) NOT NULL,
                `phone` varchar(13) NOT NULL,
                `password` varchar(60) NOT NULL,
                PRIMARY KEY (`admin_id`),
                UNIQUE KEY `Email_ID` (`email`)
                );
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step4-code')" data-element-id="step4-code">Copy</button>
        </div>

        <div>
            <h2>Step 5: Insert Admin Data</h2>
            <p>Insert initial admin data into the <strong>admins</strong> table with the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step5-code">
                INSERT INTO `admins` (`admin_id`, `name`, `email`, `phone`, `password`) VALUES
                (999999, 'admin', 'admin@gmail.com', '9090909090', 'password');
                COMMIT;
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step5-code')" data-element-id="step5-code">Copy</button>
        </div>

        <div>
            <h2>Step 6: Create Course Table</h2>
            <p>Create the <strong>courses</strong> table in your database using the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step6-code">
                CREATE TABLE IF NOT EXISTS `courses` (
                  `id` int NOT NULL AUTO_INCREMENT,
                  `course_id` varchar(10) NOT NULL,
                  `course_name` varchar(30) NOT NULL,
                  `course_length` int NOT NULL,
                  `course_description` text NOT NULL,
                  PRIMARY KEY (`id`)
                );
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step6-code')" data-element-id="step6-code">Copy</button>
        </div>

        <div>
            <h2>Step 7: Create Course Join History Table</h2>
            <p>Create the <strong>course_join_history</strong> table in your database using the following SQL code:</p>
            <div class="code-snippet-container">
            <pre class="code-snippet" id="step7-code">
                CREATE TABLE IF NOT EXISTS `course_join_history` (
                  `id` int NOT NULL AUTO_INCREMENT,
                  `user_id` int NOT NULL,
                  `course_id` varchar(10) NOT NULL,
                  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                  PRIMARY KEY (`id`),
                  FOREIGN KEY (user_id) REFERENCES users(id),
                  FOREIGN KEY (course_id) REFERENCES courses(course_id)
                );
            </pre>
            </div>
            <button class="copy-button" onclick="copyToClipboard('step7-code')" data-element-id="step7-code">Copy</button>
        </div>

        <script>
            function copyToClipboard(elementId) {
                const codeSnippet = document.getElementById(elementId).textContent;
                const tempTextArea = document.createElement('textarea');
                tempTextArea.value = codeSnippet;
                document.body.appendChild(tempTextArea);
                tempTextArea.select();
                document.execCommand('copy');
                document.body.removeChild(tempTextArea);

                // Update the button text
                const copyButton = document.querySelector(`button[data-element-id="${elementId}"]`);
                copyButton.textContent = 'Copied!';
                setTimeout(function() {
                    copyButton.textContent = 'Copy';
                }, 3000);
            }
        </script>
    </div>

</body>
</html>
