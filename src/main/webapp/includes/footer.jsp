	<!-- Footer -->
<%@page import="java.util.Date"%>
<footer class="py-5 bg-dark">
		<div class="container">
			<c:set var="anyo" value="<%= new java.util.Date() %>"/>
			<p class="m-0 text-center text-white">
				Copyright &copy; Your Website <fmt:formatDate type="Both" pattern="yyyy MM" value="${anyo}"/>
				<!-- https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html -->
			</p>
		</div>	
		
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script
		src="https://blackrockdigital.github.io/startbootstrap-shop-item/vendor/jquery/jquery.min.js"></script>
	<script
		src="https://blackrockdigital.github.io/startbootstrap-shop-item/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<script src="https://www.youtube.com/iframe_api"></script>
		<script>
		
			/*********  VIDEO YOUTUBE API  *********/
			
			var player;
	
			function onYouTubeIframeAPIReady( ) {
			    player = new YT.Player('video-placeholder', {
			        width: 600,
			        height: 450,
			        videoId: '${videoInicio.codigo}',
			        playerVars: {
			            color: 'white',
			            playlist: '${playList}',
			            autoplay: 1
			        },
			        events: {
			            onReady: initialize
			        },
			        
			    });
			}
	
			function initialize(){
	
			    // Update the controls on load
			    updateTimerDisplay();
			    updateProgressBar();
			    
			    // Clear any old interval.
			    clearInterval(10000);
	
			    // Start interval to update elapsed time display and
			    // the elapsed part of the progress bar every second.
			    time_update_interval = setInterval(function () {
			        updateTimerDisplay();
			        updateProgressBar();
			    }, 1000)
	
			}
	
			// This function is called by initialize()
			function updateTimerDisplay(){
			    // Update current time text display.
			    $('#current-time').text(formatTime( player.getCurrentTime() ));
			    $('#duration').text(formatTime( player.getDuration() ));
			}
	
			function formatTime(time){
			    time = Math.round(time);
			    var minutes = Math.floor(time / 60),
			    seconds = time - minutes * 60;
			    seconds = seconds < 10 ? '0' + seconds : seconds;
			    return minutes + ":" + seconds;
			}
	
			$('#progress-bar').on('mouseup touchend', function (e) {
			    // Calculate the new time for the video.
			    // new time in seconds = total duration in seconds * ( value of range input / 100 )
			    var newTime = player.getDuration() * (e.target.value / 100);
	
			    // Skip video to new time.
			    player.seekTo(newTime);
	
			});
	
			// This function is called by initialize()
			function updateProgressBar(){
			    // Update the value of our progress bar accordingly.
			    $('#progress-bar').val((player.getCurrentTime() / player.getDuration()) * 100);
			}
	
			$('#play').on('click', function () {
			    player.playVideo();
			});
	
			$('#pause').on('click', function () {
			    player.pauseVideo();
			});
			
			/********* FIN VIDEO YOUTUBE API  *********/
		
		</script>
		
	<script>

			
	

		function focusLogin() {

			$("form[action=login] input[name='usuario']").focus();

		}
		
		
		function showModalEliminar(id,op){
			$("#modalEliminar").modal("show");
			$("#btnEliminar").attr("href", "inicio?id="+id+"&op="+op);
		}
		
		function showModalModificar(id, nombre){
			$("#modalModificar").modal("show");
			$("#btnEliminar").attr("href", "inicio");
			$("input[name='nombreEdit']").val(nombre);
		}
		
		
	</script>

</body>

</html>