<cfsetting enablecfoutputonly=1>

<!---Dummy reference for the page that calls the calendar in : "index.cfm" or "events.cfm" etc.--->
<cfset cp = ATTRIBUTES.callingPage />

<!---Test event info. This would normally be dynamic from a database or collection.--->
<cfset edate = DateFormat(Now(),"M-D-YYYY") />
<cfset eid = 1 />
<cfset eventhdr = "Hello" />
<cfset eventdetails = "Hello event details" />
<!---//--->

<!---Display test event info. This shows as a fallback if jQuery UI doesn't kick in.--->
<cfif StructKeyExists(URL, "eid")>
   <cfif IsNumeric(eid)>
      <cfoutput>
         <div>
            <h2>#eventhdr#</h2>
            <div class="event-date">#DateFormat(edate, "DDDD - MMMM DD, YYYY")#</div>
            <div><p>#eventdetails#</p></div>
         </div>
      </cfoutput>
   </cfif>
</cfif>
<!---//--->

<!---Make date from URL--->
<cfif StructKeyExists(URL, "date")>
   <cftry>
      <cfset thisMonth = DateFormat(URL.date, "M-D-YYYY") />
      <cfcatch type="any">
         <cfset thisMonth = DateFormat(Now(), "M-D-YYYY") />
      </cfcatch>
   </cftry>
<cfelse>
   <cfset thisMonth = DateFormat(Now(), "M-D-YYYY") />
</cfif>
<!---//--->

<cfset thisMonth = "#DateFormat(thisMonth, "M")# - 1 - #DateFormat(thisMonth, "YYYY")#" />
<cfset lastMonth = DateFormat(DateAdd("M", -1, thisMonth), "M-D-YYYY") />
<cfset nextMonth = DateFormat(DateAdd("M", 1, thisMonth), "M-D-YYYY") />
<cfset totalDays = DaysInMonth(thisMonth)>
<cfset showDays = false />
<cfset thisDay = 1 />

<cfoutput>
   <table id="calendar">
      <tr>
         <td class="cal-nav">
            <a href="#cp#?date=#lastMonth#"><- Previous</a>
        </td>
         <td class="cal-hdr" colspan="5">
            #DateFormat(thisMonth, "mmmm - yyyy")#
        </td>
         <td class="cal-nav">
            <a href="#cp#?date=#nextMonth#">Next -></a>
        </td>
      </tr>
      <tr>
        <cfloop from="1" to="7" index="i">
        <td class="cal-square cal-day">#DateFormat(i, "DDDD")#</td>
        </cfloop>
      </tr>
      <tr> 
         <cfloop from="1" to="42" index="j">
            <cfif (j LTE 7) AND (DateFormat(thisMonth, "DDDD") IS DateFormat(j, "DDDD"))>
               <cfset showDays = true />
            </cfif>
            <cfif thisDay GT totalDays>
               <cfset showDays = false />
            </cfif>
            <cfif showDays>
               <cfset squareDate = "#DateFormat(thisMonth, "M")# - #thisDay# - #DateFormat(thisMonth, "YYYY")#" />
               <td class="cal-square cal-day-active top <cfif squareDate EQ DateFormat(Now())>cal-today</cfif>">
                  <table>
                     <tr>
                        <cfif squareDate EQ edate>
                        <td>
                           <div class="cal-day-square">#thisDay#</div>
                           <!---This would normally be a dynamically populated line holding variable values from a db or similar.--->
                           <div id="view" class="cal-event"><a id="event" href="#cp#?date=#edate#&eid=#eid#">Event #eid#</a></div>
                        </td>
                        <!---This is the modal window jQuery UI will trigger to display "event" info.--->
                        <cfoutput>
                           <div id="dialog" class="window">
                              <h2>#eventhdr#</h2>
                              <div class="event-date">#DateFormat(edate,"DDDD - MMMM DD, YYYY")#</div>
                              <div><p>#eventdetails#</p></div>
                           </div>
                        </cfoutput>
                        <!---//--->
                        <cfelse> 
                        <td>
                           <div class="cal-day-square">#thisDay#</div>
                        </td>
                        </cfif>
                     </tr>
                  </table>
               </td>
               <cfset thisDay = thisDay + 1 />
            <cfelse>
               <td class="cal-square cal-day-null"></td>
            </cfif> 
            <cfif j MOD 7 IS 0></tr>
               <cfif NOT j NEQ 42><tr></cfif>
            </cfif>
         </cfloop>
      </tr> 
</table>
</cfoutput>

<cfsetting enablecfoutputonly=0>
