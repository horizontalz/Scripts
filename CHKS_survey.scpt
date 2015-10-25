set SiteName to do shell script "hostname | cut -d -  -f1"
set BrowserType to "Firefox"
set AD to "WJ646KY"
set BP to "RP492TQ"
set DU to "VF323AV"
set EC to "GN632VY"
set ES to "NG673YP"
set FM to "AE369JJ"
set HV to "GA223PW"
set JB to "QM973NX"
set NX to "AE436JC"
set OH to "WQ766HW"
set PV to "YM263RE"
set WH to "WW964GZ"
set JD to "AF634FP"
set JLS to "FJ946WT"
set TR to "QT796MD"
set GH to "VZ246HT"
set PH to "DM347KJ"


## Addison
if SiteName is equal to "AD" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & AD & "/"
	end tell
	
	## Barron Park
else if SiteName is equal to "BP" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & BP & "/"
	end tell
	
	## Duveneck
else if SiteName is equal to "DU" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & DU & "/"
	end tell
	
	## El Carmelo
else if SiteName is equal to "EC" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & EC & "/"
	end tell
	
	## Escondido
else if SiteName is equal to "ES" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & ES & "/"
	end tell
	
	## Fairmeadow
else if SiteName is equal to "FM" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & FM & "/"
	end tell
	
	## Hoover
else if SiteName is equal to "HV" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & HV & "/"
	end tell
	
	## Juana Briones
else if SiteName is equal to "JB" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & JB & "/"
	end tell
	
	## Nixon
else if SiteName is equal to "NX" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & NX & "/"
	end tell
	
	## Ohlone
else if SiteName is equal to "OH" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & OH & "/"
	end tell
	
	## Palo Verde
else if SiteName is equal to "PV" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & PV & "/"
	end tell
	
	## Walter Hays
else if SiteName is equal to "WH" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & WH & "/"
	end tell
	
	## Jordan
else if SiteName is equal to "JD" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & JD & "/"
	end tell
	
	## JLS
else if SiteName is equal to "JLS" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & JLS & "/"
	end tell
	
	## Terman
else if SiteName is equal to "TR" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & TR & "/"
	end tell
	
	## Gunn
else if SiteName is equal to "GH" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & GH & "/"
	end tell
	
	## Paly
else if SiteName is equal to "PH" then
	tell application BrowserType
		open location "https://surveys.wested.org/chks/" & PH & "/"
	end tell
	
	
	## If computer name does not a recognizable site prefix	
else if SiteName is not equal to "AD" or "BP" or "DU" or "EC" or "EC" or "ES" or "FM" or "HV" or "JB" or "NX" or "OH" or "PV" or "WH" or "JD" or "JLS" or "TR" or "GH" or "PH" then
	choose from list {"Addison", "Barron Park", "Duveneck", "El Carmelo", "Escondido", "Fairmeadow", "Hoover", "Juana Briones", "Nixon", "Ohlone", "Palo Verde", "Walter Hays", "Jordan", "JLS", "Terman", "Henry Gunn High", "Palo Alto High"} with title "Location of Survey" with prompt "Select Your Site" OK button name "Select" cancel button name "Cancel" default items {"Addison"}
	set SelectedSite to result
	
	## Addison
	if SelectedSite is equal to {"Addison"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & AD & "/"
		end tell
		
		## Barron Park
	else if SelectedSite is equal to {"Barron Park"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & BP & "/"
		end tell
		
		## Duveneck
	else if SelectedSite is equal to {"Duveneck"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & DU & "/"
		end tell
		
		## El Carmelo
	else if SelectedSite is equal to {"El Carmelo"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & EC & "/"
		end tell
		
		## Escondido
	else if SelectedSite is equal to {"Escondido"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & ES & "/"
		end tell
		
		## Fairmeadow
	else if SelectedSite is equal to {"Fairmeadow"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & FM & "/"
		end tell
		
		## Hoover
	else if SelectedSite is equal to {"Hoover"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & HV & "/"
		end tell
		
		## Juana Briones
	else if SelectedSite is equal to {"Juana Briones"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & JB & "/"
		end tell
		
		## Nixon
	else if SelectedSite is equal to {"Nixon"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & NX & "/"
		end tell
		
		## Ohlone
	else if SelectedSite is equal to {"Ohlone"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & OH & "/"
		end tell
		
		## Palo Verde
	else if SelectedSite is equal to {"Palo Verde"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & PV & "/"
		end tell
		
		## Walter Hays
	else if SelectedSite is equal to {"Walter Hays"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & WH & "/"
		end tell
		
		## Jordan
	else if SelectedSite is equal to {"Jordan"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & JD & "/"
		end tell
		
		## JLS
	else if SelectedSite is equal to {"JLS"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & JLS & "/"
		end tell
		
		## Terman
	else if SelectedSite is equal to {"Terman"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & TR & "/"
		end tell
		
		## Gunn
	else if SelectedSite is equal to {"Henry Gunn High"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & GH & "/"
		end tell
		
		## Paly
	else if SelectedSite is equal to {"Palo Alto High"} then
		tell application BrowserType
			open location "https://surveys.wested.org/chks/" & PH & "/"
		end tell
		
	end if
	
	
end if
