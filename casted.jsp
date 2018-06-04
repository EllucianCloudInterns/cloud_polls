<html>
<head>
	<title> Cloud Ops // Book Poll Results </title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

	<style>
		.center_rect {
			margin: auto;
			width: 50%;
			border: 3px solid grey;
			padding: 10px;
		}
		.center {
			margin: auto;
			width: 50%;
		}
		.hidden {
			display: none;
		}


		.column {
    		float: left;
    		width: 50%;
		}
		.row:after {
    		content: "";
    		display: table;
    		clear: both;
		}
	</style>
	<script>

		function reveal() {
			var x = document.getElementById("hidden_text");
			var y = document.getElementById("results_button");
			if (x.style.display == "none") {
				x.style.display = "block";
				y.innerHTML = "Hide Results";
			}
			else {
				x.style.display = "none";
				y.innerHTML = "View Results";
			}
		}

	</script>
</head>
<body>

	<div class="w3-top">
  		<div class="w3-bar" id="myNavbar">
    		<a href="index.html#home" class="w3-bar-item w3-button" style = "color:black">HOME</a>
    		<a href="index.html#polls" class="w3-bar-item w3-button w3-hide-small" style = "color:black"><i class="fa fa-th"></i> POLLS </a>
  		</div>
	</div>



	<br>
	<br>
	<div class = center_rect> 
		<h3 style = "text-align: center;"> Thank You For Casting Your Vote </h3>
		<h4 style = "text-align: center;"> You Voted For 

			<%
				String[] bookNames = {"The Phoenix Project", "Getting Things Done", "The Anatomy of Peace", "The DevOps HandBook", "Garfield in Space"};
				out.println(bookNames[Integer.parseInt(request.getParameter("AID"))]);
			%>
		</h4>
		<center>
			<button id = "results_button" class = "btn btn-outline-primary" onclick="reveal()"> View Results </button>
		</center>
	</div>
	<br>
	<br>
	<div id = "hidden_text" class = "hidden center_rect">

		<h4 style = "text-align: center;">

		<%@ page import="java.io.*" %>	
		<%
			String vote = request.getParameter("AID");
			String fileToRead = vote+".txt";
            // System.out.println(fileToRead);

             // -------------------------------------------------- //



			String voter = request.getParameter("name");
			File voters = new File("webapps/cloudops_polling/voters.txt");

			BufferedWriter bv = new BufferedWriter(new FileWriter(voters, true));

			String towrite = voter + " - " + bookNames[Integer.parseInt(vote)];

			bv.write(towrite);
			bv.newLine();
			bv.flush();
			bv.close();



             // -------------------------------------------------- //


            InputStream ins = application.getResourceAsStream(fileToRead);
            BufferedReader breader = new BufferedReader(new InputStreamReader(ins));
            
            int num_votes = Integer.parseInt(breader.readLine());
            num_votes++;

            breader.close();
            ins.close();

            // -------------------------------------------------- //

            File ftw = new File("webapps/cloudops_polling/"+vote+".txt");

            BufferedWriter bw = new BufferedWriter(new FileWriter(ftw));

            bw.write(Integer.toString(num_votes));
            bw.flush();
            bw.close();


            // -------------------------------------------------- //

            int max_votes = 0;
            int max_book = 0;

            int[] vote_count = new int[5];

            for (int i = 0; i < 5; i++) {
            	String bookfile = i+".txt"; 
            	InputStream inss = application.getResourceAsStream(bookfile);
            	BufferedReader br = new BufferedReader(new InputStreamReader(inss));


            	int nv; 
            	if (i != Integer.parseInt(vote)) {
            		nv = Integer.parseInt(br.readLine());
            	}
            	else {
            		nv = num_votes;
            }

            	vote_count[i] = nv;
            	if (nv > max_votes) {
            		max_votes = nv;
            		max_book = i;
            	}

            	br.close();
 				inss.close();
        	}

        	Boolean tie = false;

        	for (int i = 0; i < 5; i++) {
        		if (i != max_book && vote_count[i]== max_votes) {
        			tie = true;
        		}
        	}

        	if (!tie) {
        		out.println("Current Winner: " + bookNames[max_book]);
        	}
        	else {
        		out.println("Currently Tied");
        	}	

		%>
		</h4>
		<div class = row>
			<div class = column>
		<%
			for (int i = 0; i < 5; i++) {
			%>
				<p style = "text-align: center;">
			<%
				out.println(bookNames[i] +": " + vote_count[i]);
			}
			%>
		</p>
			</div>
			<div class = column>
				<center>
					<% 
					if (tie) {
					%>
						<img src="images/tie_book.jpg" style="width: 50%">
						<%
					}
					else if (max_book == 0) {
					%>
						<img src="images/phoenix_project.jpg" style="width: 32%; border-width: 2px; border-style: solid;">
						<%
					}
					else if (max_book == 1) {
					%>
						<img src="images/getting_things_done.jpg" style="width: 32%; border-width: 2px; border-style: solid;">
						<%
					}
					else if (max_book == 2) {
					%>
						<img src="images/anatomy_of_peace.jpg" style="width: 32%; border-width: 2px; border-style: solid;">
						<%
					}
					else if (max_book == 3) {
					%>
						<img src="images/devOps_handbook.jpg" style="width: 32%; border-width: 2px; border-style: solid;">
						<%
					}
					else {
					%>
						<img src="images/garfield_in_space.jpg" style="width: 45%; border-width: 2px; border-style: solid;">
						<%
					}
					%>	
				</center>
		</div>


	</div>
</body>
</html>