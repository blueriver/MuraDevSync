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
<cfcomponent output="false" extends="mura.plugin.plugincfc">
	
	<cfset variables.cfapplication=expandPath("/muraWRM/config/cfapplication.cfm")>
	
	<cffunction name="install" output="false">
		<cfset update()>	
	</cffunction>
	
	<cffunction name="update" output="false">
		
		<cfset super.update()>	
		<cfset removeCode()>
		<cfset addCode()>
	</cffunction>
	
	<cffunction name="delete" output="false">
		<cfset super.delete()>
		<cfset removeCode()>
	</cffunction>
	
	<cffunction name="removeCode" output="false">
		<cfset var file="">
		<cfset var finder="">
		
		<cffile action="read" file="#variables.cfapplication#" variable="file">
		<cfset finder=reFindNoCase("(<!--- BeginDevSync --->).+?(<!--- EndDevSync --->)",file,1,"true")>
		<cfif finder.len[1]>
			<cfset file=replaceNoCase(file,mid(file, finder.pos[1], finder.len[1]),'')>
			<cfset getBean("fileWriter").writeFile(file=variables.cfapplication, output="#file#")>
		</cfif>
		
	</cffunction>
		
	<cffunction name="addCode" output="false">
		<cfset var code=chr(10) & chr(13) & "<!--- BeginDevSync ---><cfif isdefined('url.#application.configBean.getAppreloadKey()#')><cfset createObject('component','MuraDevSync.sync').init()></cfif><!--- EndDevSync --->">
		<cfset getBean("fileWriter").appendFile(file=variables.cfapplication, output="#code#", newline=true)>
	</cffunction>
	

</cfcomponent>
