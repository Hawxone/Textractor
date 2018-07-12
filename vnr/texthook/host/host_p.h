#pragma once
// host_p.h
// 8/24/2013 jichi
// Branch IHF/main.h, rev 111
#include <windows.h>
#include <tlhelp32.h>

#define GLOBAL extern
#define SHIFT_JIS 0x3A4
class HookManager;
//class CommandQueue;
class SettingManager;
class TextHook;
//class BitMap;
//class CustomFilterMultiByte;
//class CustomFilterUnicode;
//#define TextHook Hook
GLOBAL BOOL running;
//GLOBAL BitMap *pid_map;
//GLOBAL CustomFilterMultiByte *mb_filter;
//GLOBAL CustomFilterUnicode *uni_filter;
GLOBAL HookManager *man;
//GLOBAL CommandQueue *cmdq;
GLOBAL SettingManager *setman;
GLOBAL WCHAR recv_pipe[];
GLOBAL WCHAR command[];
GLOBAL HANDLE pipeExistsEvent;
GLOBAL DWORD split_time,
             cyclic_remove,
             clipboard_flag,
             global_filter;
GLOBAL CRITICAL_SECTION detachCs;

DWORD WINAPI TextReceiver(LPVOID lpThreadParameter);
DWORD WINAPI CmdThread(LPVOID lpThreadParameter);

DWORD  GetCurrentPID();
//DWORD  GetProcessIDByPath(LPWSTR str);
HANDLE  GetCommandPipe(DWORD pid);
//DWORD  Inject(HANDLE hProc);
//DWORD  InjectByPID(DWORD pid);
//DWORD  PIDByName(LPWSTR target);
//DWORD  Hash(LPCWSTR module, int length=-1);

// EOF
