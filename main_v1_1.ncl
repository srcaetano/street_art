<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo18" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<!-- Regions for initial screen -->
			<region id="rg_nclua" left="0px" width="1280px" top="0px" height="720px" zIndex="1"/>
		</regionBase>
		<descriptorBase>
			<!-- Descriptors for initial screen -->
			<descriptor id="dp_nclua" region="rg_nclua" focusIndex="1" focusBorderWidth="0"/>
		</descriptorBase>
		<connectorBase>
			<causalConnector id="onBeginSetN">
				<connectorParam name="value"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="set" max="unbounded" operator="par" value="$value"/>
			</causalConnector>
			<causalConnector id="onBeginStopN">
				<simpleCondition role="onBegin"/>
				<simpleAction role="stop" max="unbounded" qualifier="par"/>
			</causalConnector>
		</connectorBase>
	</head>
	<body id="app_body">
		<!-- Lua media to run Healthcare app -->
		<port id="pt_start_nclua" component="md_nclua"/>
		<media id="md_nclua" descriptor="dp_nclua" src="lua/menu.lua"/>
		
		<!-- Media variable to focus on media -->
		<media id="md_setn" type="application/x-ginga-settings">
			<property name="service.currentKeyMaster" value=""/>
			<property name="service.currentFocus" value=""/>
		</media>
		
		<!-- Action for initial screen -->
		<link xconnector="onBeginSetN">
			<bind role="onBegin" component="md_nclua" />
			<bind role="set"     component="md_setn" interface="service.currentKeyMaster">
				<bindParam name="value" value="md_nclua"/>
			</bind>
			<bind role="set"     component="md_setn" interface="service.currentFocus">
				<bindParam name="value" value="1"/>
			</bind>
		</link>
		
		<!-- Action to end application 
		<link xconnector="onBeginStopN">
			<bind role="onBegin" component="md_nclua"  interface="stop_nclua"/>
			<bind role="stop"    component="app_body"/>
		</link>-->
	</body>
</ncl>