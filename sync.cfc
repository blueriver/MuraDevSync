<cfcomponent output="false">

<cffunction name="init" output="false">
	<cfargument name="context">
	<cfhttp url="http://#cgi.http_host##arguments.context#/plugins/MuraDevSync/sync.cfc?method=doSync">
</cffunction>

<cffunction name="doSync" output="false" access="remote">
<cfscript>
	var i=0;
	var xml=XmlParse(fileread(expandPath("/MuraDevSync/sync.xml")));
	var fileWriter=application.serviceFactory.getBean("fileWriter");
	var pluginManager=application.serviceFactory.getBean("pluginManager");
		
	if(isDefined("xml.DevSync.plugins.plugin") and arrayLen(xml.DevSync.plugins.plugin)){
		i=0;
		while(i lt arrayLen(xml.DevSync.plugins.plugin)){
			i=i+1;
			fileWriter.copyDir(xml.DevSync.plugins.plugin[i].xmlAttributes.external, expandPath("/#xml.DevSync.plugins.plugin[i].xmlAttributes.package#"));				
			pluginManager.reDeploy(id=xml.DevSync.plugins.plugin[i].xmlAttributes.package);
		}			
	}
			
	if(isDefined("xml.DevSync.directories.directory") and arrayLen(xml.DevSync.directories.directory)){
		i=0;
		while(i lt arrayLen(xml.DevSync.directories.directory)){
			i=i+1;
			fileWriter.copyDir(xml.DevSync.plugins.plugin[i].xmlAttributes.external, expandPath("/muraWRM#xml.DevSync.plugins.plugin[i].xmlAttributes.internal#"));								
		}			
	}
</cfscript>
</cffunction>

</cfcomponent>