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
<cfinclude template="plugin/config.cfm" />

<cfsavecontent variable="body">
<cfoutput>
<h2>#variables.pluginConfig.getName()#</h2>
<p>This is a proof of concept plugin designed to allow devlopers to link installed plugins and themes to external directories.  Each time Mura reloads it copies the latest code from the external directories.</p>
<p>The mappings are configured in the sync.xml at the root of the plugin.<p>

<p>#HTMLEditFormat('<DevSync>')#</br>
#HTMLEditFormat('<plugins>')#</br>
#HTMLEditFormat('<plugin package="example" external="/complete/path/to/external/directory"/>')#</br>
#HTMLEditFormat('</plugins>')#</br>
#HTMLEditFormat('<directories>')#</br>
#HTMLEditFormat('<diretory internal="/default/includes/default/themes/merced" external="/complete/path/to/external/directory"/>')#</br>
#HTMLEditFormat('</directories>')#</br>
#HTMLEditFormat('</DevSync>')#</p>

</cfoutput>
</cfsavecontent>
<cfoutput>
#application.pluginManager.renderAdminTemplate(body=body,pageTitle=variables.pluginConfig.getName())#
</cfoutput>

