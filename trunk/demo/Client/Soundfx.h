/*---------------------------------------------------------

    ���� �ʱ�ȭ

        SoundOpen(������ �ڵ�);

        LoadWavLis("����Ʈ ����");

    ���� �÷���

        ������� => PlayBGM("�������");
        ȿ����   => PlaySound(ȿ���� �ε���, ����(0~10));

    ��溼������
        ChangeBGMVolume(����(0~10));

    ����Off
        Silence();

    ������� Replay

         ������ �޼��� ó����ƾ����
         MM_MCINOTIFY �޼������� ó��

        if (Message.Msg == MM_MCINOTIFY)
        {
            ReplayBGM();
            Message.Result = true;
        } else
        {
            TForm::WndProc(Message);
        }


    ���� ����

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