<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="debug" type="java.lang.Boolean" required="false" %>

<script type="text/javascript" src="build/vendor.js"></script>
<link href="build/vendor.css" rel="stylesheet">

<c:choose>
	<c:when test="${debug}">
		<link href="build/cascheid.css" rel="stylesheet">
		<div id="custom_js_scripts">
		<script type="text/javascript" src="js/index.app.js"></script>
		<script type="text/javascript" src="js/common/common.service.js"></script>
		<script type="text/javascript" src="js/common/identity.service.js"></script>
		<script type="text/javascript" src="js/index/mist.js"></script>
		<script type="text/javascript" src="js/index/rain.js"></script>
		<script type="text/javascript" src="js/index/waterAnim.js"></script>
		<script type="text/javascript" src="js/index/index.controller.js"></script>
		<script type="text/javascript" src="js/index/about.controller.js"></script>
		<script type="text/javascript" src="js/games/games.controller.js"></script>
		<script type="text/javascript" src="js/games/racing.controller.js"></script>
		<script type="text/javascript" src="js/games/racing.service.js"></script>
		<script type="text/javascript" src="js/games/racing.user.controller.js"></script>
		</div>
	</c:when>
	<c:otherwise>
		<link href="build/cascheid.min.css" rel="stylesheet">
		<script type="text/javascript" src="build/cascheid.min.js"></script>
	</c:otherwise>
</c:choose>