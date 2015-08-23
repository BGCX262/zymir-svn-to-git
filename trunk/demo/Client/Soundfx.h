/*---------------------------------------------------------

    사운드 초기화

        SoundOpen(윈도우 핸들);

        LoadWavLis("리스트 파일");

    사운드 플레이

        배경음악 => PlayBGM("배경파일");
        효과음   => PlaySound(효과음 인덱스, 볼륨(0~10));

    배경볼륨조절
        ChangeBGMVolume(볼륨(0~10));

    볼륨Off
        Silence();

    배경음악 Replay

         윈도우 메세지 처리루틴에서
         MM_MCINOTIFY 메세지에서 처리

        if (Message.Msg == MM_MCINOTIFY)
        {
            ReplayBGM();
            Message.Result = true;
        } else
        {
            TForm::WndProc(Message);
        }


    사운드 종료

        SoundClose()
-----------------------------------------------------------*/

procedure SoundOpen(hWnd:HWND): bool;
procedure SoundClose();
procedure LoadWavList(listfile:AnsiString);
procedure PlayBGM(str:AnsiString);
procedure RePlayBGM();
procedure PlaySound(soundindex:integer, volum:integer);
procedure ChangeBGMVolume(volume:integer);
procedure Silence();