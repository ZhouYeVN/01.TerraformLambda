@echo off
rem run from script folder
pushd %~dp0

rem load .\.env (ignore blank lines and lines starting with # or ;)
if exist ".\.env" (
    for /f "usebackq tokens=1* delims==" %%A in (".\.env") do (
        rem skip comments/empty names
        if not "%%A"=="" (
            set "LINE_KEY=%%A"
            set "LINE_VAL=%%B"
            rem trim trailing CR (in case of mixed line endings)
            for /f "delims=" %%K in ("!LINE_KEY!") do set "LINE_KEY=%%K"
            for /f "delims=" %%V in ("!LINE_VAL!") do set "LINE_VAL=%%V"
            rem ignore comment lines that start with # or ;
            setlocal enabledelayedexpansion
            set "firstChar=!LINE_KEY:~0,1!"
            if not "!firstChar!"=="#" if not "!firstChar!"==";" (
                set "%LINE_KEY%=%LINE_VAL%"
            )
            endlocal & for /f "tokens=1* delims==" %%x in ("%%A=%%B") do (
                rem re-export into outer env (necessary due to setlocal/endlocal)
                if not "%%x"=="" set "%%x=%%y"
            )
        )
    )
) else (
    echo Warning: env not found
)

rem show loaded non-secret info for debugging (do not print secrets)
if defined AWS_ACCESS_KEY_ID echo AWS_ACCESS_KEY_ID=%AWS_ACCESS_KEY_ID%
if defined AWS_DEFAULT_REGION echo AWS_DEFAULT_REGION=%AWS_DEFAULT_REGION%

rem run terraform with passed args
terraform %*

popd