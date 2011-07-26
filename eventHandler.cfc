<!---
   Copyright 2011 Blue River Interactive

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->
<cfcomponent extends="mura.plugin.pluginGenericEventHandler" output="false">

<cffunction name="onApplicationLoad" output="false">
	<cfargument name="$">
	
	<cfscript>
		var pluginManager=getBean("pluginManager");
		var fileWriter=getBean("fileWriter");
		var i=0;
		var xml=XmlParse(fileread(expandPath("/DevSync/sync.xml")));
		
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
				fileWriter.copyDir(xml.DevSync.plugins.plugin[i].xmlAttributes.external, expandPath("/#xml.DevSync.plugins.plugin[i].xmlAttributes.internal#"));							
			}
				
		}
	</cfscript>
</cffunction>

</cfcomponent>