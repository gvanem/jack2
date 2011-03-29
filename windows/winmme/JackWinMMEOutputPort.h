/*
Copyright (C) 2011 Devin Anderson

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*/

#ifndef __JackWinMMEOutputPort__
#define __JackWinMMEOutputPort__

#include <mmsystem.h>
#include <windows.h>

#include "JackMidiAsyncQueue.h"
#include "JackMidiBufferReadQueue.h"

namespace Jack {

    class JackWinMMEOutputPort {

    private:

        static void CALLBACK
        HandleMessageEvent(HMIDIOUT handle, UINT message, DWORD_PTR port,
                           DWORD_PTR param1, DWORD_PTR param2);

        void
        GetMMErrorString(MMRESULT error, LPTSTR text);

        void
        GetOSErrorString(LPTSTR text);

        void
        HandleMessage(UINT message, DWORD_PTR param1, DWORD_PTR param2);

        bool
        Wait(Handle semaphore);

        void
        WriteMMError(const char *jack_func, const char *mm_func,
                     MMRESULT result);

        void
        WriteOSError(const char *jack_func, const char *os_func);

        char alias[JACK_CLIENT_NAME_SIZE + JACK_PORT_NAME_SIZE];
        HMIDIOUT handle;
        char name[JACK_CLIENT_NAME_SIZE + JACK_PORT_NAME_SIZE];
        JackMidiBufferReadQueue *read_queue;
        HANDLE sysex_semaphore;
        JackMidiAsyncQueue *thread_queue;
        HANDLE thread_queue_semaphore;

    public:

        JackWinMMEOutputPort(const char *alias_name, const char *client_name,
                             const char *driver_name, UINT index,
                             size_t max_bytes=4096, size_t max_messages=1024);

        ~JackWinMMEOutputPort();

        bool
        Execute();

        bool
        Init();

        void
        ProcessJack(JackMidiBuffer *port_buffer, jack_nframes_t frames);

        bool
        Start();

        bool
        Stop();

    };

}

#endif
