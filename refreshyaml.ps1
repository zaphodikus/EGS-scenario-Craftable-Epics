# A helper script which coppies the default scenario playfiled files over the top of your scenario
# , then finally copies all the files into this folder to allow a checkin into git.

# To use this script for a scenario please configure the variables
$scenario_name = "Craftable Epics"
$scenario_id = "$( $scenario_name )__2337746040"
$base_scenario = "Default Random"

# the target work folder
$local_root   = join-path $pwd $scenario_name

# game folders
$content_root = "C:\SteamLibrary\steamapps\common\Empyrion - Galactic Survival\Content"
$scenario_root = join-path (join-path $content_root "Scenarios") $scenario_id
# based off of "Default Random"
$content_base_scenario = join-path (join-path $content_root "Scenarios") $base_scenario

$randompresets_root = join-path $content_root "RandomPresets"
write-host "Steam Scenario location: $($scenario_root)"

#1: Copy all the SolarSystemConfig.yaml files from the Empyrion - Galactic Survival/Content/RandomPresets folder 
# into the RandomPresets folder of this scenario.
write-host ("-" *80)
write-host "1. Copy SolarSystemConfig.yaml files 'RandomPresets/*.*"
write-host "Copy from '${randompresets_root}'"
write-host "Copy to '$( (join-path $scenario_root 'RandomPresets'))'"
#ls (join-path $scenario_root 'RandomPresets') | write-host

#2: Copy the gameoptions.yaml and gameoptions_example.yaml files from Empyrion - Galactic Survival/Content/Scenarios/Default Random 
# and put them in the main folder of this scenario.
write-host ("-" *80)
write-host "2. Copy ""Default Random"" gameoptions yaml files"
write-host "Copy from '$content_base_scenario'"
write-host "Copy to '$( $scenario_root )'"
test-path $content_base_scenario | write-host
test-path $scenario_root | write-host
write-host ("-" *80)

# 3. copy files into the git local repo
write-host "2. Copy entire folder into local repo"
write-host "Copy from '$scenario_root'"
write-host "Copy to '$local_root'"
New-Item -ItemType Directory -Path $local_root -Force -ea 0 | Out-Null	# Ensure target folder exists 1st time
Copy-Item -Path $scenario_root\* -Destination $local_root -Recurse -Force # overwrite all
git status
