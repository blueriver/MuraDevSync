<cfcomponent output="false">

<cffunction name="init" output="false">
<cfscript>
	var i=0;
	var xml=XmlParse(fileread(expandPath("/DevSync/sync.xml")));
	var fileWriter="";
	
	if(isdefined("application.serviceFactory")){
		
		fileWriter=application.serviceFactory.getBean("fileWriter");
		
		if(isDefined("xml.DevSync.plugins.plugin") and arrayLen(xml.DevSync.plugins.plugin)){
			i=0;
			while(i lt arrayLen(xml.DevSync.plugins.plugin)){
				i=i+1;
				try{
					fileWriter.copyDir(xml.DevSync.plugins.plugin[i].xmlAttributes.external, expandPath("/#xml.DevSync.plugins.plugin[i].xmlAttributes.package#"));				
					pluginManager.reDeploy(id=xml.DevSync.plugins.plugin[i].xmlAttributes.package);
				}
				catch(Any err){}
			}			
		}
			
		if(isDefined("xml.DevSync.directories.directory") and arrayLen(xml.DevSync.directories.directory)){
			i=0;
			while(i lt arrayLen(xml.DevSync.directories.directory)){
				i=i+1;
				try{
					fileWriter.copyDir(xml.DevSync.plugins.plugin[i].xmlAttributes.external, expandPath("/muraWRM#xml.DevSync.plugins.plugin[i].xmlAttributes.internal#"));								
				}
				catch(Any err){}
			}			
		}
	}
</cfscript>
</cffunction>

</cfcomponent>