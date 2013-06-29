<?php
if(isset($success) && $success){
	echo '<div class="dosuccess">' . $success . '</div>';

	echo '
		<script type="text/javascript">
			$(function(){
				setTimeout(function(){$(".dosuccess").fadeOut()},3000);
			});
		</script>
	';
}
if(isset($error) && $error){
	echo '<div class="doerror">' . $error . '</div>';

	echo '
		<script type="text/javascript">
			$(function(){
				setTimeout(function(){$(".doerror").fadeOut()},3000);
			});
		</script>
	';
}
?>
</body>
</html>