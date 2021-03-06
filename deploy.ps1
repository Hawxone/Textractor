﻿param([string]$version)

cd $PSScriptRoot;
mkdir -Force -Verbose Builds;
cd Builds;
mkdir -Force -Verbose x86;
mkdir -Force -Verbose x64;

foreach ($language in @{
	ENGLISH="";
	SPANISH="Español";
	SIMPLIFIED_CHINESE="简体中文";
	RUSSIAN="Русский";
	TURKISH="Türkçe";
	INDONESIAN="Bahasa";
}.GetEnumerator())
{
	$folder = "Textractor-$($language.Value)-$version";
	mkdir -Force -Verbose $folder;
	rm -Force -Recurse -Verbose "$folder/*";

	foreach ($arch in @("x86", "x64"))
	{
		cd $arch;
		$cmakeArch = if ($arch -eq "x86") {""} else {" Win64"};
		$vsArch = if ($arch -eq "x86") {"Win32"} else {"x64"};
		cmake -G "Visual Studio 15 2017$cmakeArch" -DVERSION="$version" -DTEXT_LANGUAGE="$($language.Key)" -DCMAKE_BUILD_TYPE="Release" ../..;
		&"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv" Textractor.sln /build "Release|$vsArch";
		cd ..;
		mkdir -Force -Verbose "$folder/$arch";
		foreach ($file in @(
			"Textractor.exe",
			"TextractorCLI.exe",
			"texthook.dll",
			"Qt5Core.dll",
			"Qt5Gui.dll",
			"Qt5Widgets.dll",
			"LoaderDll.dll",
			"LocaleEmulator.dll",
			"Bing Translate.dll",
			"Copy to Clipboard.dll",
			"Extra Newlines.dll",
			"Extra Window.dll",
			"Google Translate.dll",
			"Lua.dll",
			"Regex Filter.dll",
			"Remove Repetition.dll",
			"Replacer.dll",
			"Thread Linker.dll",
			"platforms",
			"styles"
		))
		{
			copy -Force -Recurse -Verbose -Destination "$folder/$arch" -Path "Release_$arch/$file";
		}
	}
}
