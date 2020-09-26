## ----------------------------------------------------------------------
## MIX SPLITTER
## ----------------------------------------------------------------------

## Most music compilations give you a "HH:MM:SS - Artist - Title" format, so that's what we're going with.
## Make sure to sanitize punctuation like question marks.
## Yes, this can get pretty huge. Make sure you don't miss any commas or quotes.
$songArray = "00:00:00 - DJ Hidden - Death Seer", "00:05:30 - Darchives - First Offensive", "00:09:47 - Photek - Smoke Rings", "00:14:47 - Bad Company - Forgotten", "00:17:22 - Black Sun Empire - Tell Me What You See", "00:20:46 - Grooverider - Where's Jack the Ripper", "00:23:42 - DJ Teebee - Redwind", "00:28:51 - Future Prophecies - Miniamba (Feat. Mari Boine)", "00:31:48 - Bad Company - The Nine", "00:36:35 - Technical Itch - The Rukus", "00:38:03 - Dom Roland - Imagination", "00:43:50 - Konflict - Messiah", "00:48:57 - Eye-D - Unicorn MF (Black Sun Empire Remix)", "00:52:38 - Rawthang - Scorned (Feat. Kari)", "01:00:20 - Kemal & Rob Data - Konspiracy", "01:02:33 - Ed Rush & Optical - Sick Note", "01:05:29 - Typecell - Bad Illusions (Black Sun Empire Remix)", "01:07:19 - Future Prophecies - Jack the Groove", "01:11:44 - Skynet - Hydroflash", "01:17:05 - Technical Itch - Heavy Metal", "01:18:33 - Photek - Minotaur", "01:22:13 - DJ Teebee - Spaceage", "01:28:15 - Bad Company - The Pulse", "01:30:27 - Spor - The Eyes Have It", "01:33:02 - Impulse - Skullfuck (Corrupt Souls Skullfucked Mix)", "01:38:37 - Dillinja - Silver Blade", "01:48:07 - Bad Company - Colonies", "01:50:49 - ASC - Windchime"

## Change these to match the file you're working with.
$songCounter = 1
$fullFileLength = "01:58:31"
$separator = " - "

ForEach ($song in $songArray) { 
## These could be done directly as parameters when calling ffmpeg but I chose to turn them into their own variables for readability.
	$songStart = ($song -split $separator)[0]
	$songArtist = ($song -split $separator)[1]
	$songTitle = ($song -split $separator)[2]

## Check that it's not the final song, then check the next item on the array for the starting point of the next song. If it is the final song, have the end of the file as the end of the song.
	if ($songCounter -lt $songArray.Count){
		$songEnd = $songArray[$songCounter]
		$songEnd = ($songEnd -split $separator)[0]
	} else {
		$songEnd = $fullFileLength
	}
	
## Summon ffmpeg and pass all the relevant parameters.
	./ffmpeg -i "mp3/Terminus _ Techstep + Drum and Bass Mix.mp3" -metadata TPE1="$songArtist" -metadata TIT2="$songTitle" -metadata TRCK="$songCounter" -ss $songStart -to $songEnd -c copy "mp3/$songArtist - $songTitle.mp3"
	
## Increment the counter and do it again!
	$songCounter++
}
