#ifndef jack_export_h
#define jack_export_h

#if defined(_WIN32)
  #define DLL_EXPORT __declspec(dllexport)
  #define DLL_IMPORT __declspec(dllimport)
#else
  #define DLL_EXPORT
  #define DLL_IMPORT
#endif

/*
 * A '-DBUILDING_JACK_DLL' must be in CFLAGS when compiling .c/.cpp-files
 * that go into 'bin/libJack.dll'.
 */
#if defined(BUILDING_JACK_DLL)
  #define Jack_API_EXPORT  DLL_EXPORT
#else
  #define Jack_API_EXPORT  DLL_IMPORT
#endif

/*
 * Similarily for 'bin/libJackServer.dll'.
 */
#if defined(BUILDING_JACK_SERVER_DLL)
  #define JackServer_API_EXPORT  DLL_EXPORT
#else
  #define JackServer_API_EXPORT  DLL_IMPORT
#endif

/*
 * Hack alert:
 *   Some functions in both 'common/JackLibAPI.cpp' and 'common/JackServerAPI.cpp'
 *   need to be exported from both .DLLs. Rather confusing, but true.
 */
#if defined(BUILDING_JACK_DLL) || defined(BUILDING_JACK_SERVER_DLL)
  #define JackDual_API_EXPORT  DLL_EXPORT
#else
  #define JackDual_API_EXPORT  DLL_IMPORT
#endif

/*
  For drivers like 'bin/jack/jack_dummy.dll', there is no need to add
  * '-DBUILDING_JACK_DUMMY_DLL' since the needed symbols are exported using
  * the macro '$(call link_DLL_driver, ..)'.
  *
  * Also note, for non-Windows, this file should do nothing.
  */
#endif
