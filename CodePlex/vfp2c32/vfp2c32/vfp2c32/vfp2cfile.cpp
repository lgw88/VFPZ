// to make File operation (CopyFileEx ..) defines and types available
#include <windows.h>
#include <stdio.h>
#include <winioctl.h>
#include <uxtheme.h>

#include "pro_ext.h"
#include "vfp2c32.h"
#include "vfp2cutil.h"
#include "vfp2cfile.h"
#include "vfp2ccppapi.h"
#include "vfp2chelpers.h"
#include "vfpmacros.h"

// dynamic function pointers for runtime linking
static PGETSPECIALFOLDER fpGetSpecialFolder = 0;
static PSHILCREATEFROMPATH fpSHILCreateFromPath = 0;
static PSHILCREATEFROMPATHEX fpSHILCreateFromPathEx = 0;
static PGETVOLUMEPATHNAMESFORVOLUMENAME fpGetVolumePathNamesForVolumeName = 0;

// Filesearch class implementation
bool FileSearch::FindFirst(char *pSearch)
{
	m_Handle = FindFirstFile(pSearch,&File);
	if (m_Handle == INVALID_HANDLE_VALUE)
	{
		DWORD nLastError = GetLastError();
		if (nLastError == ERROR_FILE_NOT_FOUND)
			return false;
		else
		{
			SaveWin32Error("FindFirstFile", nLastError);
			throw E_APIERROR;
		}
	}
	return true;
}

bool FileSearch::FindNext()
{
	BOOL bNext = FindNextFile(m_Handle,&File);
	if (bNext == FALSE)
	{
		DWORD nLastError = GetLastError();
        if (nLastError == ERROR_NO_MORE_FILES)
		{
			FindClose(m_Handle);
			m_Handle = INVALID_HANDLE_VALUE;
			return false;
		}
		else
		{
			SaveWin32Error("FindNextFile", nLastError);
			throw E_APIERROR;
		}
	}
	return true;
}

bool FileSearch::IsFakeDir() const
{
	if ((File.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) > 0)
		return strcmp(File.cFileName,".") == 0 || strcmp(File.cFileName,"..") == 0;
	else
		return false;
}


VolumeSearch::~VolumeSearch()
{ 
	if (m_Handle != INVALID_HANDLE_VALUE)
		FindVolumeClose(m_Handle);
}

bool VolumeSearch::FindFirst()
{
	m_Handle = FindFirstVolume(m_Volume, m_Volume.Size());
	if (m_Handle == INVALID_HANDLE_VALUE)
	{
		DWORD nLastError = GetLastError();
		if (nLastError == ERROR_FILE_NOT_FOUND)
			return false;
		else
		{
			SaveWin32Error("FindFirstVolume", nLastError);
			throw E_APIERROR;
		}
	}
	m_Volume.StringLen();
	return true;
}

bool VolumeSearch::FindNext()
{
	BOOL bNext = FindNextVolume(m_Handle, m_Volume, m_Volume.Size());
	if (bNext == FALSE)
	{
		DWORD nLastError = GetLastError();
        if (nLastError == ERROR_NO_MORE_FILES)
		{
			FindVolumeClose(m_Handle);
			m_Handle = INVALID_HANDLE_VALUE;
			return false;
		}
		else
		{
			SaveWin32Error("FindNextVolume", nLastError);
			throw E_APIERROR;
		}
	}
	m_Volume.StringLen();
	return true;
}

VolumeMountPointSearch::~VolumeMountPointSearch()
{ 
	if (m_Handle != INVALID_HANDLE_VALUE)
		FindVolumeMountPointClose(m_Handle);
}

bool VolumeMountPointSearch::FindFirst(char *pVolume)
{
	m_Handle = FindFirstVolumeMountPoint(pVolume, m_MountPoint, m_MountPoint.Size());
	if (m_Handle == INVALID_HANDLE_VALUE)
	{
		DWORD nLastError = GetLastError();
		if (nLastError != ERROR_NO_MORE_FILES && nLastError != ERROR_NOT_READY)
		{
			SaveWin32Error("FindFirstVolumeMountPoint", nLastError);
			throw E_APIERROR;
		}
		else
			return false;
	}
	m_MountPoint.StringLen();
	return true;
}

bool VolumeMountPointSearch::FindNext()
{
	BOOL bNext = FindNextVolumeMountPoint(m_Handle, m_MountPoint, m_MountPoint.Size());
	if (bNext == FALSE)
	{
		DWORD nLastError = GetLastError();
        if (nLastError == ERROR_NO_MORE_FILES)
		{
			FindVolumeMountPointClose(m_Handle);
			m_Handle = INVALID_HANDLE_VALUE;
			return false;
		}
		else
		{
			SaveWin32Error("FindNextVolumeMountPoint", nLastError);
			throw E_APIERROR;
		}
	}
	m_MountPoint.StringLen();
	return true;
}

// init file functions
bool _stdcall VFP2C_Init_File(VFP2CTls& tls)
{
	HMODULE hDll;
	bool bRetVal = true;
	
	hDll = GetModuleHandle("kernel32.dll");
	if (hDll)
	{
		fpGetVolumePathNamesForVolumeName = (PGETVOLUMEPATHNAMESFORVOLUMENAME)GetProcAddress(hDll, "GetVolumePathNamesForVolumeNameA");
	}
	else
	{
		AddWin32Error("GetModuleHandle", GetLastError());
		bRetVal = false;
	}

	hDll = GetModuleHandle("shell32.dll");
	if (hDll)
	{
		fpGetSpecialFolder = (PGETSPECIALFOLDER)GetProcAddress(hDll,"SHGetSpecialFolderPathA");
		fpSHILCreateFromPath = (PSHILCREATEFROMPATH)GetProcAddress(hDll,"SHILCreateFromPath");
		fpSHILCreateFromPathEx = (PSHILCREATEFROMPATHEX)GetProcAddress(hDll,(LPCSTR)SHILCREATEFROMPATHEXID);
	}
	else
	{
		AddWin32Error("GetModuleHandle", GetLastError());
		bRetVal = false;
	}

	return bRetVal;
}

// cleanup
void _stdcall VFP2C_Destroy_File(VFP2CTls& tls)
{
	// release all file handles
	while(!tls.FileHandles.IsEmpty())
		CloseHandle(tls.FileHandles.RemoveTail());
}

void _fastcall ADirEx(ParamBlk *parm)
{
try
{
	FoxString pDestination(p1);
	FoxString pSearchString(p2);
	DWORD nFileFilter = PCount() >= 3 && p3.ev_long ? p3.ev_long : ~FILE_ATTRIBUTE_FAKEDIRECTORY;
	int nDest = PCount() >= 4 && p4.ev_long ? p4.ev_long : ADIREX_DEST_ARRAY;

	FoxString pFileName(MAX_PATH+1);
	FoxArray pArray;
	FoxCursor pCursor;
	FoxDateTime pFileTime;
	FoxInt64 pFileSize;
	FileSearch pSearch;
	FoxDateTimeLiteral pCreationTime, pAccessTime, pWriteTime;

	CStr pCallback;
	CStr pCallbackCmd;

	bool bToLocal = (nDest & ADIREX_UTC_TIMES) == 0;
	bool bEnumFakeDirs = (nFileFilter & FILE_ATTRIBUTE_FAKEDIRECTORY) != 0;
	nFileFilter &= ~FILE_ATTRIBUTE_FAKEDIRECTORY;

	unsigned int nFileCnt = 0;
	PADIREXFILTER fpFilterFunc;

	if (!(nDest & (ADIREX_DEST_ARRAY | ADIREX_DEST_CURSOR | ADIREX_DEST_CALLBACK)))
		nDest |= ADIREX_DEST_ARRAY;

	if ((nDest & ADIREX_DEST_CALLBACK) && pDestination.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;
	
	if (nDest & ADIREX_FILTER_ALL)
		fpFilterFunc = AdirExFilter_All;
	else if (nDest & ADIREX_FILTER_NONE)
		fpFilterFunc = AdirExFilter_None;
	else if (nDest & ADIREX_FILTER_EXACT)
		fpFilterFunc = AdirExFilter_Exact;
	else
		fpFilterFunc = AdirExFilter_One;

	// destination is array
	if (nDest & ADIREX_DEST_ARRAY)
	{
		pArray.Dimension((char*)pDestination,1,7);
		pArray.AutoGrow(16);
	}
	// else if destination is cursor
	else if (nDest & ADIREX_DEST_CURSOR)
	{
		pCursor.Create(pDestination,"filename C(254), dosfilename C(13), creationtime T, accesstime T, writetime T, filesize N(20,0), fileattribs I");
	}
	else // destination is callback procedure
	{
		pCallbackCmd.Size(VFP2C_MAX_CALLBACKBUFFER);
		pCallback = pDestination;
		pCallback += "('%S','%S',%S,%S,%S,%0F,%U)";
	}
	
	if (!pSearch.FindFirst(pSearchString))
	{
		Return(0);
		return;
	}

	if (nDest & ADIREX_DEST_ARRAY) // if destination is array
	{
		do 
		{
			if (fpFilterFunc(pSearch.File.dwFileAttributes,nFileFilter))
			{
				if (!bEnumFakeDirs && pSearch.IsFakeDir())
					continue;
				
				nFileCnt = pArray.Grow();
				pArray(nFileCnt,1) = pFileName = pSearch.File.cFileName;
				pArray(nFileCnt,2) = pFileName = pSearch.File.cAlternateFileName;

				pFileTime = pSearch.File.ftCreationTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pArray(nFileCnt,3) = pFileTime;

				pFileTime = pSearch.File.ftLastAccessTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pArray(nFileCnt,4) = pFileTime;

				pFileTime = pSearch.File.ftLastWriteTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pArray(nFileCnt,5) = pFileTime;

				pArray(nFileCnt,6) = pFileSize = pSearch.Filesize();
				pArray(nFileCnt,7) = pSearch.File.dwFileAttributes;

			} // endif nFileFilter

		} while(pSearch.FindNext());

		pArray.ReturnRows();
	}
	else if (nDest & ADIREX_DEST_CURSOR) // destination is cursor ...
	{
		do 
		{
			if (fpFilterFunc(pSearch.File.dwFileAttributes,nFileFilter))
			{

				if (!bEnumFakeDirs && pSearch.IsFakeDir())
					continue;

				nFileCnt++;
				pCursor.AppendBlank();
				pCursor(0) = pFileName = pSearch.File.cFileName;
				pCursor(1) = pFileName = pSearch.File.cAlternateFileName;

				pFileTime = pSearch.File.ftCreationTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pCursor(2) = pFileTime;

				pFileTime = pSearch.File.ftLastAccessTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pCursor(3) = pFileTime;

				pFileTime = pSearch.File.ftLastWriteTime;
				if (bToLocal)
					pFileTime.ToLocal();
				pCursor(4) = pFileTime;

				pCursor(5) = pFileSize = pSearch.Filesize();
				pCursor(6) = pSearch.File.dwFileAttributes;

			} // endif nFileFilter

		} while(pSearch.FindNext());

		Return(nFileCnt);
	}
	else // call callback procedure
	{
		double nFileSize;
		FoxValue vRetVal;

		do 
		{
			if (fpFilterFunc(pSearch.File.dwFileAttributes,nFileFilter))
			{
				if (!bEnumFakeDirs && pSearch.IsFakeDir())
					continue;
				
				nFileCnt++;
				pCreationTime.Convert(pSearch.File.ftCreationTime,bToLocal);
				pAccessTime.Convert(pSearch.File.ftLastAccessTime,bToLocal);
				pWriteTime.Convert(pSearch.File.ftLastWriteTime,bToLocal);
				nFileSize = (double)pSearch.Filesize();
	            
				pCallbackCmd.Format(pCallback, pSearch.File.cFileName, pSearch.File.cAlternateFileName, 
									(char*)pCreationTime, (char*)pAccessTime, (char*)pWriteTime, nFileSize, pSearch.File.dwFileAttributes);

				vRetVal.Evaluate(pCallbackCmd);
				if (vRetVal.Vartype() != 'L' || !vRetVal->ev_length)
					break;
			} // endif nFileFilter

		} while(pSearch.FindNext());

		Return(nFileCnt);
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

bool _stdcall AdirExFilter_All(DWORD nAttributes, DWORD nFilter)
{
	return (nAttributes & nFilter) == nFilter;
}

bool _stdcall AdirExFilter_One(DWORD nAttributes, DWORD nFilter)
{
	return (nAttributes & nFilter) > 0;
}

bool _stdcall AdirExFilter_None(DWORD nAttributes, DWORD nFilter)
{
	return (nAttributes & nFilter) == 0;
}

bool _stdcall AdirExFilter_Exact(DWORD nAttributes, DWORD nFilter)
{
	return nAttributes == nFilter;
}

void _fastcall ADirectoryInfo(ParamBlk *parm)
{
try
{
	if (p2.ev_length > MAXFILESEARCHPARAM)
		throw E_INVALIDPARAMS;

	FoxArray pArray(p1,3,1);
	FoxString pDirectory(p2);
	FoxInt64 pFileSize;
	CStr pSearch(MAX_PATH);

	DIRECTORYINFO sDirInfo = {0,0,0,0};

	pSearch = pDirectory;
	pSearch.AddBs();

	ADirectoryInfoSubRoutine(&sDirInfo, pSearch);

	pArray(1) = sDirInfo.nNumberOfFiles;
	pArray(2) = sDirInfo.nNumberOfSubDirs;
	pArray(3) = pFileSize = sDirInfo.nDirSize;
}
catch (int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _stdcall ADirectoryInfoSubRoutine(LPDIRECTORYINFO pDirInfo, CStr& pDirectory) throw(int)
{
	FileSearch pSearch;
	CStr pFileSearch(MAX_PATH);

	if (pDirectory.Len() > MAXFILESEARCHPARAM)
	{
		SaveCustomError("ADirectoryInfo","Path exceeds MAX_PATH characters.");
		throw E_APIERROR;
	}

	pFileSearch = pDirectory;
	pFileSearch.AddBsWc();

	if (!pSearch.FindFirst(pFileSearch))
		return;

	do 
	{
		if (pSearch.File.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
		{
			if (pSearch.IsFakeDir())
				continue;

			pDirInfo->nNumberOfSubDirs++;

			pFileSearch = pDirectory;
			pFileSearch += pSearch.Filename();
			pFileSearch.AddBs();

			ADirectoryInfoSubRoutine(pDirInfo,pFileSearch);
		}
		else
		{
			pDirInfo->nNumberOfFiles++;
			pDirInfo->nDirSize += pSearch.Filesize();
		}
	} while (pSearch.FindNext());
}

void _fastcall AFileAttributes(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1,5,1);
	FoxString pFileName(p2);
	bool bToLocal = PCount() == 2 || !p3.ev_length;
	FoxDateTime pFileTime;
	FoxInt64 pFileSize;
	WIN32_FILE_ATTRIBUTE_DATA sFileAttribs;

	if (!GetFileAttributesEx(pFileName.Fullpath(),GetFileExInfoStandard,&sFileAttribs))
	{
		SaveWin32Error("GetFileAttributesEx", GetLastError());
		throw E_APIERROR;
	}

	pArray(1) = sFileAttribs.dwFileAttributes;
	pArray(2) = pFileSize = Ints2Double(sFileAttribs.nFileSizeLow, sFileAttribs.nFileSizeHigh);
	
	pFileTime = sFileAttribs.ftCreationTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(3) = pFileTime;

	pFileTime = sFileAttribs.ftLastAccessTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(4) = pFileTime;

	pFileTime = sFileAttribs.ftLastWriteTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(5) = pFileTime;
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AFileAttributesEx(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1,9,1);
	FoxString pFileName(p2);
	bool bToLocal = PCount() == 2 || !p3.ev_length;
	FoxDateTime pFileTime;
	FoxInt64 pFileSize;
	ApiHandle hFile;
	BY_HANDLE_FILE_INFORMATION sFileAttribs;

	hFile = CreateFile(pFileName.Fullpath(),0,0,0,OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS,0);
	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	if (!GetFileInformationByHandle(hFile,&sFileAttribs))
	{
		SaveWin32Error("GetFileInformationByHandle", GetLastError());
		throw E_APIERROR;
	}

	pArray(1) = sFileAttribs.dwFileAttributes;
	pArray(2) = pFileSize = Ints2Double(sFileAttribs.nFileSizeLow, sFileAttribs.nFileSizeHigh);

	pFileTime = sFileAttribs.ftCreationTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(3) = pFileTime;

	pFileTime = sFileAttribs.ftLastAccessTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(4) = pFileTime;

	pFileTime = sFileAttribs.ftLastWriteTime;
	if (bToLocal)
		pFileTime.ToLocal();
	pArray(5) = pFileTime;

	pArray(6) = sFileAttribs.nNumberOfLinks - 1;
	pArray(7) = sFileAttribs.dwVolumeSerialNumber;
	pArray(8) = sFileAttribs.nFileIndexLow;
	pArray(9) = sFileAttribs.nFileIndexHigh;
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetFileTimes(ParamBlk *parm)
{
try
{
	if (Vartype(r2) != 'R' && Vartype(r2) != '0')
		throw E_INVALIDPARAMS;

	if (PCount() >= 3 && (Vartype(r3) != 'R' && Vartype(r3) != '0'))
		throw E_INVALIDPARAMS;

	if (PCount() >= 4 && (Vartype(r4) != 'R' && Vartype(r4) != '0'))
		throw E_INVALIDPARAMS;

	FoxString pFileName(p1);
	FoxReference pCreationTime(r2), pAccessTime(r3), pWriteTime(r4);
	bool bToLocal = PCount() < 5 || !p5.ev_length;
	FoxDateTime pFileTime;
	ApiHandle hFile;

	FILETIME sCreationTime, sAccessTime, sWriteTime;
	
	hFile = CreateFile(pFileName.Fullpath(),0,0,0,OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS,0);
	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	if (!GetFileTime(hFile,&sCreationTime,&sAccessTime,&sWriteTime))
	{	
		SaveWin32Error("GetFileTime", GetLastError());
		throw E_APIERROR;
	}

	if (Vartype(r2) == 'R')
	{
		pFileTime = sCreationTime;
		if (bToLocal)
			pFileTime.ToLocal();
		pCreationTime = pFileTime;
	}

	if (PCount() >= 3 && Vartype(r3) == 'R')
	{
		pFileTime = sAccessTime;
		if (bToLocal)
			pFileTime.ToLocal();
		pAccessTime = pFileTime;
	}

	if (PCount() >= 4 && Vartype(r4) == 'R')
	{
		pFileTime = sWriteTime;
		if (bToLocal)
			pFileTime.ToLocal();
		pWriteTime = pFileTime;
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);	
}
}

void _fastcall SetFileTimes(ParamBlk *parm)
{
try
{
	bool bCreation, bAccess, bWrite;

	if (Vartype(p2) == 'T')
		bCreation = p2.ev_real != 0.0;
	else if (Vartype(p2) == '0')
		bCreation = false;
	else
		throw E_INVALIDPARAMS;

	if (PCount() >= 3)
	{
		if (Vartype(p3) == 'T')
			bAccess = p3.ev_real != 0.0;
		else if (Vartype(p3) == '0')
			bAccess = false;
		else
			throw E_INVALIDPARAMS;
	}
	else
		bAccess = false;

	if (PCount() >= 4)
	{
		if (Vartype(p4) == 'T')
			bWrite = p4.ev_real != 0.0;
		else if (Vartype(p4) == '0')
			bWrite = false;
		else
			throw E_INVALIDPARAMS;
	}
	else
		bWrite = false;

	if (!bCreation && !bAccess && !bWrite)
		throw E_INVALIDPARAMS;

	FoxString pFileName(p1);
	bool bToUTC = PCount() < 5 || p5.ev_length;
	ApiHandle hFile;
	FoxDateTime pTime;

	FILETIME sCreationTime, sAccessTime, sWriteTime;

	hFile = CreateFile(pFileName.Fullpath(), FILE_WRITE_ATTRIBUTES, 0, 0, OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS, 0);
	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	if (bCreation)
	{
		pTime = p2;
		if (bToUTC)
			pTime.ToUTC();
		sCreationTime = pTime;
	}

	if (bAccess)
	{
		pTime = p3;
		if (bToUTC)
			pTime.ToUTC();
		sAccessTime = pTime;
	}

    if (bWrite)
	{
		pTime = p4;
		if (bToUTC)
			pTime.ToUTC();
		sWriteTime = pTime;
	}

	if (!SetFileTime(hFile, bCreation ? &sCreationTime : 0, bAccess ? &sAccessTime : 0, bWrite ? &sWriteTime : 0))
	{
		SaveWin32Error("SetFileTime", GetLastError());
		throw E_APIERROR;
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetFileSizeLib(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	FoxInt64 pFileSize;
	ApiHandle hFile;
	LARGE_INTEGER sSize;

	hFile = CreateFile(pFileName.Fullpath(), 0, 0, 0, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	if (!GetFileSizeEx(hFile, &sSize))
	{
		SaveWin32Error("GetFileSizeEx", GetLastError());
		throw E_APIERROR;
	}

	pFileSize = sSize.QuadPart;
	pFileSize.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetFileAttributesLib(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	DWORD nAttribs;
    
	nAttribs = GetFileAttributes(pFileName.Fullpath());
	if (nAttribs == INVALID_FILE_ATTRIBUTES)
	{
		SaveWin32Error("GetFileAttributes", GetLastError());
		throw E_APIERROR;
	}
	Return(nAttribs);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SetFileAttributesLib(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);

	if (!SetFileAttributes(pFileName.Fullpath(),p2.ev_long))
	{
		SaveWin32Error("SetFileAttributes", GetLastError());
		throw E_APIERROR;
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetFileOwner(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	FoxString pOwner(MAX_PATH);
	FoxString pDomain(MAX_PATH);
	CBuffer pDescBuffer;
	ApiHandle hFile;
	int SidType;
	
	DWORD dwSize = SECURITY_DESCRIPTOR_LEN, nLastError;
	BOOL bOwnerDefaulted;
	PSECURITY_DESCRIPTOR pSecDesc;
	PSID pOwnerId;

	hFile = CreateFile(pFileName.Fullpath(), READ_CONTROL, 0, 0, OPEN_EXISTING, 0, 0);
	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	while(1)
	{
		pDescBuffer.Size(dwSize);
		pSecDesc = reinterpret_cast<PSECURITY_DESCRIPTOR>(pDescBuffer.Address());

		if (!GetKernelObjectSecurity(hFile, OWNER_SECURITY_INFORMATION, pSecDesc, dwSize, &dwSize))
		{
			nLastError = GetLastError();
			if (nLastError != ERROR_INSUFFICIENT_BUFFER)
			{
				SaveWin32Error("GetKernelObjectSecurity", nLastError);
				throw E_APIERROR;
			}
		}
		else
			break;
	}

	if (!GetSecurityDescriptorOwner(pSecDesc,&pOwnerId,&bOwnerDefaulted))
	{
		SaveWin32Error("GetSecurityDescriptorOwner", GetLastError());
		throw E_APIERROR;
	}

	DWORD dwOwnerLen = MAX_PATH, dwDomainLen = MAX_PATH;
	if (!LookupAccountSid((LPCSTR)0,pOwnerId,pOwner,&dwOwnerLen,
		pDomain,&dwDomainLen,(PSID_NAME_USE)&SidType))	
	{
		SaveWin32Error("LookupAccountSid", GetLastError());
		throw E_APIERROR;
	}

	pOwner.Len(dwOwnerLen);
	pDomain.Len(dwDomainLen);

	FoxReference rOwner(r2);
    rOwner = pOwner;

	if (PCount() >= 3)
	{
		FoxReference rDomain(r3);
		rDomain = pDomain;
	}

	if (PCount() >= 4)
	{
		FoxReference rSid(r4);
		rSid = SidType;
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetLongPathNameLib(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	FoxString pLongFileName(MAX_PATH+1);
	
	pLongFileName.Len(GetLongPathName(pFileName.Fullpath(), pLongFileName, MAX_PATH+1));
	if (!pLongFileName.Len())
	{
		SaveWin32Error("GetLongPathName", GetLastError());
		throw E_APIERROR;
	}
	pLongFileName.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetShortPathNameLib(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	FoxString pShortName(MAX_PATH+1);

	pShortName.Len(GetShortPathName(pFileName.Fullpath(),pShortName,MAX_PATH+1));
	if (!pShortName.Len())
	{
		SaveWin32Error("GetShortPathName", GetLastError());
		throw E_APIERROR;
	}

	pShortName.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall CopyFileExLib(ParamBlk *parm)
{
try
{
	FoxString pSource(p1);
	FoxString pDest(p2);
	FoxString pCallback(parm,3);
	bool bRetVal;
	FILEPROGRESSPARAM sProgress = {0};

	if (pCallback.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;

	sProgress.bCallback = pCallback.Len() > 0;
	if (pCallback.Len())
		sprintf(sProgress.pFileProgress,"%s(%%I64d,%%I64d,%%.2f)",(char*)pCallback);

	bRetVal = CopyFileProgress(pSource,pDest,&sProgress);
	Return(bRetVal);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall MoveFileExLib(ParamBlk *parm)
{
try
{
 	FoxString pSource(p1);
 	FoxString pDest(p2);
	FoxString pCallback(parm,3);
	bool bCrossVolume, bRetVal;
	FILEPROGRESSPARAM sProgress = {0};

	if (pCallback.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;

	sProgress.bCallback = pCallback.Len() > 0;
	bCrossVolume = !PathIsSameVolume(pSource,pDest);

	// builds the format command to be called back , %% is reduced to one % by sprintf
	if (sProgress.bCallback)
		sprintf(sProgress.pFileProgress,"%s(%%I64d,%%I64d,%%.2f)", (char*)pCallback);

	bRetVal = MoveFileProgress(pSource, pDest, INVALID_FILE_ATTRIBUTES, bCrossVolume, &sProgress);
	Return(bRetVal);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

bool MoveFileProgress(char *pSourceFile, char *pDestFile, DWORD nAttributes, bool bCrossVolume,
				  LPFILEPROGRESSPARAM pProgress) throw(int)
{
	if (bCrossVolume)
	{
 		if (CopyFileProgress(pSourceFile,pDestFile,pProgress))
 			DeleteFileExEx(pSourceFile,nAttributes);
		else
			return false;
	}
	else
	{
		if (!MoveFile(pSourceFile,pDestFile))
		{
			SaveWin32Error("MoveFile", GetLastError());
			throw E_APIERROR;
		}
	}
	return true;
}


bool _stdcall CopyFileProgress(char *pSource, char *pDest, LPFILEPROGRESSPARAM pProgress) throw(int)
{
	int nBuffSize;
	ApiHandle hSource, hDest;
	CBuffer pReadBuffer;
	__int64 nFileSize, nSize, nBytesCopied = 0;
	DWORD nBytesRead;
	double nPercentCopied;
	BY_HANDLE_FILE_INFORMATION sFileAttribs;

	hSource = CreateFile(pSource,GENERIC_READ,FILE_SHARE_READ,0,OPEN_EXISTING,FILE_FLAG_SEQUENTIAL_SCAN,0);
	if (!hSource)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}
	
	if (!GetFileInformationByHandle(hSource,&sFileAttribs))
	{
		SaveWin32Error("GetFileInformationByHandle", GetLastError());
		throw E_APIERROR;
	}

	hDest = CreateFile(pDest,GENERIC_WRITE,0,0,CREATE_ALWAYS,sFileAttribs.dwFileAttributes,0);
	if (!hDest)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	nFileSize = nSize = Ints2Int64(sFileAttribs.nFileSizeLow, sFileAttribs.nFileSizeHigh);

	if (nSize < 1024*1024)
		nBuffSize = MAX_USHORT;
	else if (nSize < 1024*1024*10)
		nBuffSize = MAX_USHORT * 4;
	else if (nSize < 1024*1024*100)
		nBuffSize = MAX_USHORT * 16;
	else if (nSize < 1024*1024*500)
		nBuffSize = MAX_USHORT * 32;
	else 
		nBuffSize = MAX_USHORT * 64;

	pReadBuffer.Size(nBuffSize);

    while (nSize)
	{
		if (nSize > nBuffSize)
			nBytesRead = nBuffSize;
		else
			nBytesRead = (int)nSize;

		nSize -= nBytesRead;

		if (!ReadFile(hSource,pReadBuffer,nBytesRead,&nBytesRead,0))
		{
			SaveWin32Error("ReadFile", GetLastError());
			throw E_APIERROR;
		}

		if (!WriteFile(hDest,pReadBuffer,nBytesRead,&nBytesRead,0))
		{
			SaveWin32Error("WriteFile", GetLastError());
			throw E_APIERROR;
		}

		if (pProgress->bCallback)
		{
			nBytesCopied += nBytesRead;		
			nPercentCopied = (double)nBytesCopied / (double)nFileSize * 100;
			sprintf(pProgress->pCallback,pProgress->pFileProgress,nBytesCopied,nFileSize,nPercentCopied);
			Evaluate(pProgress->vRetVal,pProgress->pCallback);
			if (!pProgress->vRetVal.ev_length)
			{
				pProgress->bAborted = true;
				break;
			}
		}
	}

	hSource.Close();
	hDest.Close();

	if (pProgress->bAborted)
		DeleteFileExEx(pDest,INVALID_FILE_ATTRIBUTES);
	return !pProgress->bAborted;
}

void _fastcall CompareFileTimes(ParamBlk *parm)
{
try
{
	FoxString pFile1(p1);
	FoxString pFile2(p2);
	int nRetVal;

	nRetVal = CompareFileTimesEx(pFile1.Fullpath(),pFile2.Fullpath());
	Return(nRetVal);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall DeleteFileEx(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	
	pFileName.Fullpath();
	if (pFileName.Len() <= MAX_PATH)
		DeleteFileExEx(pFileName, INVALID_FILE_ATTRIBUTES);
	else
	{
		if (pFileName[0] != '\\' || pFileName[1] != '\\' || pFileName[2] != '?' || pFileName[3] != '\\')
			pFileName.Prepend("\\\\?\\");
		FoxWString pFileNameW(pFileName);
		DeleteFileExExW(pFileNameW, INVALID_FILE_ATTRIBUTES);
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall DeleteDirectory(ParamBlk *parm)
{
try
{
	FoxString pDirectory(p1);
	DeleteDirectoryEx(pDirectory);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHSpecialFolder(ParamBlk *parm)
{
try
{
	if (!fpGetSpecialFolder)
		throw E_NOENTRYPOINT;

	FoxString pFolder(MAX_PATH+1);
	FoxReference pRef(r2);
	BOOL bCreateDir = PCount() >= 3 ? p3.ev_length : FALSE;

	if (fpGetSpecialFolder(WTopHwnd(),pFolder,p1.ev_long, bCreateDir))
	{
		pFolder.Len(strlen(pFolder));
		pRef = pFolder;
		Return(true);
	}
	else
		Return(false);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHCopyFiles(ParamBlk *parm)
{
try
{
	FoxString pFrom(p1,2);
	FoxString pTo(p2,2);
	FoxString pTitle(parm,4);

	SHFILEOPSTRUCT sFileOp = {0};

	sFileOp.wFunc = FO_COPY;
	sFileOp.fFlags = (FILEOP_FLAGS)p3.ev_long;
	sFileOp.hwnd = WTopHwnd();

	sFileOp.pFrom = pFrom;
	sFileOp.pTo = pTo;

	if (pTitle.Len())
	{
		sFileOp.fFlags |= FOF_SIMPLEPROGRESS;
		sFileOp.lpszProgressTitle = pTitle;
	}

	int nRet = SHFileOperation(&sFileOp);
	if (nRet == 0 && sFileOp.fAnyOperationsAborted == FALSE)
		Return(1);
	else if (sFileOp.fAnyOperationsAborted)
		Return(0);
	else
		Return(nRet);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHDeleteFiles(ParamBlk *parm)
{
try
{
	FoxString pFile(p1,2);
	FoxString pTitle(parm,3);

	SHFILEOPSTRUCT sFileOp = {0};

	sFileOp.wFunc = FO_DELETE;
	sFileOp.fFlags = (FILEOP_FLAGS)p2.ev_long;
	sFileOp.hwnd = WTopHwnd();

	sFileOp.pFrom = pFile;

	if (pTitle.Len())
	{
		sFileOp.fFlags |= FOF_SIMPLEPROGRESS;
		sFileOp.lpszProgressTitle = pTitle;
	}

	int nRet = SHFileOperation(&sFileOp);
	if (nRet == 0 && sFileOp.fAnyOperationsAborted == FALSE)
		Return(1);
	else if (sFileOp.fAnyOperationsAborted)
		Return(0);
	else
		Return(nRet);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHMoveFiles(ParamBlk *parm)
{
try
{
	FoxString pFrom(p1,2);
	FoxString pTo(p2,2);
	FoxString pTitle(parm,4);

	SHFILEOPSTRUCT sFileOp = {0};
    
	sFileOp.wFunc = FO_MOVE;
	sFileOp.fFlags = (FILEOP_FLAGS)p3.ev_long;
	sFileOp.hwnd = WTopHwnd();

	sFileOp.pFrom = pFrom;
	sFileOp.pTo = pTo;

	if (pTitle.Len())
	{
		sFileOp.fFlags |= FOF_SIMPLEPROGRESS;
		sFileOp.lpszProgressTitle = pTitle;
	}

	int nRet = SHFileOperation(&sFileOp);
	if (nRet == 0 && sFileOp.fAnyOperationsAborted == FALSE)
		Return(1);
	else if (sFileOp.fAnyOperationsAborted)
		Return(0);
	else
		Return(nRet);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHRenameFiles(ParamBlk *parm)
{
try
{
	FoxString pFrom(p1,2);
	FoxString pTo(p2,2);
	FoxString pTitle(parm,4);

	SHFILEOPSTRUCT sFileOp = {0};

	sFileOp.wFunc = FO_RENAME;
	sFileOp.fFlags = (FILEOP_FLAGS)p3.ev_long;
	sFileOp.hwnd = WTopHwnd();

	sFileOp.pFrom = HandleToPtr(p1);
	sFileOp.pTo = HandleToPtr(p2);

	if (pTitle.Len())
	{
		sFileOp.fFlags |= FOF_SIMPLEPROGRESS;
		sFileOp.lpszProgressTitle = pTitle;
	}

	int nRet = SHFileOperation(&sFileOp);
	if (nRet == 0 && sFileOp.fAnyOperationsAborted == FALSE)
		Return(1);
	else if (sFileOp.fAnyOperationsAborted)
		Return(0);
	else
		Return(nRet);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall SHBrowseFolder(ParamBlk *parm)
{
try
{
	FoxString pTitle(p1);
	FoxReference pRef(r3);
	FoxWString pRootFolder(parm,4);
	FoxString pCallback(parm,5);
	FoxString pFolder(MAX_PATH);
	CoTaskPtr pIdl, pRootIdl;

	BROWSEINFO sBrow;
	BrowseCallback sCallback;
	char aDisplayName[MAX_PATH];
	HRESULT hr;
	DWORD nRootAttr = 0;

	if (pCallback.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;

	if (pRootFolder)
	{
		if (fpSHILCreateFromPath)
		{
			hr = fpSHILCreateFromPath(pRootFolder,pRootIdl,&nRootAttr);
			if (FAILED(hr))
			{
				SaveCustomError("SHILCreateFromPath", "Function failed. HRESULT: %I", hr);
				throw E_APIERROR;
			}
		}
		else
			pRootIdl = fpSHILCreateFromPathEx(pRootFolder);

		sBrow.pidlRoot = pRootIdl;
	}
	else
		sBrow.pidlRoot = 0;

	if (pCallback.Len())
	{
		sCallback.pCallback = pCallback;
		sCallback.pCallback += "(%U,%U,%U)";
	}

	sBrow.lpfn = pCallback.Len() ? SHBrowseCallback : 0;
	sBrow.lParam = pCallback.Len() ? reinterpret_cast<LPARAM>(&sCallback) : 0;
	sBrow.iImage = 0;
	sBrow.hwndOwner = WTopHwnd();
	sBrow.pszDisplayName = aDisplayName;
	sBrow.lpszTitle = pTitle;
	sBrow.ulFlags = p2.ev_long;

	pIdl = SHBrowseForFolder(&sBrow);

	if (pIdl)
	{
		if (!SHGetPathFromIDList(pIdl,pFolder))
		{
			SaveCustomError("SHGetPathFromIDList","Function failed.");
			throw E_APIERROR;
		}
		pRef = pFolder.StringLen();
		Return(true);
	}
	else
		Return(false);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

int _stdcall SHBrowseCallback(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData)
{
	int nRetVal = 0;
try
{
	FoxValue vRetVal;
	BrowseCallback *lpBC = reinterpret_cast<BrowseCallback*>(lpData);
	lpBC->pBuffer.Format(lpBC->pCallback, hwnd, uMsg, lParam);

	vRetVal.Evaluate(lpBC->pBuffer);
	if (vRetVal.Vartype() == 'I')
		nRetVal = vRetVal->ev_long;
	else if (vRetVal.Vartype() == 'L')
		nRetVal = vRetVal->ev_length;
	else if (vRetVal.Vartype() == 'N')
		nRetVal = static_cast<int>(vRetVal->ev_real);
}
catch(int nErrorNo) { nErrorNo = 0; }
return nRetVal;
}

void _fastcall GetOpenFileNameLib(ParamBlk *parm)
{
try
{
	FoxString pFilter(parm,2,2);
	FoxString pFileName(parm,3);
	FoxString pInitialDir(parm,4);
	FoxString pTitle(parm,5);
	FoxArray pArray(parm,7);
	FoxString pCallback(parm,8);
	FoxString pFiles(MAX_OPENFILENAME_BUFFER);
	FoxString pFileBuffer;

	OPENFILENAME sFile = {0};
	OpenfileCallback sCallbackParam;

	if (pFileName.Len() > MAX_OPENFILENAME_BUFFER)
		throw E_INVALIDPARAMS;

	if (pCallback.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;

	if (PCount() >= 1 && p1.ev_long)
		sFile.Flags = p1.ev_long & ~(OFN_ENABLETEMPLATE | OFN_ENABLETEMPLATEHANDLE | OFN_ALLOWMULTISELECT);
	else
		sFile.Flags = OFN_EXPLORER | OFN_NOCHANGEDIR | OFN_NODEREFERENCELINKS | 
			OFN_FILEMUSTEXIST |	OFN_DONTADDTORECENT;

	if (PCount() >= 6)
		sFile.FlagsEx = p6.ev_long;

	sFile.lStructSize = sizeof(OPENFILENAME);
	sFile.Flags |= OFN_ENABLEHOOK;
	sFile.lpfnHook = &GetFileNameCallback;

	sFile.hwndOwner = WTopHwnd();

	if (pFileName.Len())
		pFiles = pFileName;
	else
		pFiles[0] = '\0';

	sFile.lpstrFile = pFiles; 
	sFile.nMaxFile = pFiles.Size();

	if (pFilter.Len())
		sFile.lpstrFilter = pFilter;
	else if (!(sFile.Flags & OFN_EXPLORER))
		sFile.lpstrFilter = "All\0*.*\0";

	sFile.lpstrInitialDir = pInitialDir;
	sFile.lpstrTitle = pTitle;

	// if an arrayname is passed for multiselect
	if (pArray)
	{
		// allocate memory for the Value structure to store the filenames
		pFileBuffer.Size(MAX_PATH+1);
		// set multiselect flag
		sFile.Flags |= OFN_ALLOWMULTISELECT;
	}

	// if a callback function is passed
	if (pCallback.Len())
	{
		// setup the OPENFILECALLBACK structure
		sFile.lCustData = (LPARAM)&sCallbackParam;
		// build the callback string passed to sprintfex
		sCallbackParam.pCallback = pCallback;
		sCallbackParam.pCallback += "(%I,%U,%I)";
	}

	if (GetOpenFileName(&sFile))
	{
		if (sFile.Flags & OFN_ALLOWMULTISELECT)
		{
			int nFileCount;
			char *pFilePtr = pFiles;
			unsigned int nRow = 0;

			if (sFile.Flags & OFN_EXPLORER)
			{
				nFileCount = pFiles.StringDblCount();
				pArray.Dimension(nFileCount);

				while (nFileCount--)
				{
					nRow++;
					pArray(nRow) = pFileBuffer = pFilePtr;
					// advance pointer by length of string + 1 for nullterminator
					pFilePtr += pFileBuffer.Len() + 1;
				}
			}
			else
			{
				// when OFN_EXPLORER flag is not set, files are seperated by a space character
				nFileCount = pFiles.GetWordCount(' ');
				pArray.Dimension(nFileCount);
				
				while (nFileCount--)
				{
					nRow++;
					pFileBuffer.Len(GetWordNumN(pFileBuffer,pFilePtr,' ',1,MAX_PATH+1));
					pArray(nRow) = pFileBuffer;
					// advance pointer by length of string + 1 for space
					pFilePtr += pFileBuffer.Len() + 1;
				}
			}
			pArray.ReturnRows();
		}
		else
			pFiles.StringLen().Return();
	}
	else
	{
		DWORD nLastError = CommDlgExtendedError();
		if (nLastError)
		{
			SaveCustomError("GetOpenFileName", "Function failed: %I", nLastError);
			Return(-1);
		}
		else
			Return(0);
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetSaveFileNameLib(ParamBlk *parm)
{
try
{
	FoxString pFilter(parm,2,2);
	FoxString pFileName(parm,3);
	FoxString pInitialDir(parm,4);
	FoxString pTitle(parm,5);
	FoxString pCallback(parm,7);
	FoxString pFiles(MAX_OPENFILENAME_BUFFER);

	OPENFILENAME sFile = {0};
	OpenfileCallback sCallbackParam;

	if (pFileName.Len() > MAX_OPENFILENAME_BUFFER)
		throw E_INVALIDPARAMS;

	if (pCallback.Len() > VFP2C_MAX_CALLBACKFUNCTION)
		throw E_INVALIDPARAMS;

	if (PCount() >= 1 && p1.ev_long)
		sFile.Flags = p1.ev_long & ~(OFN_ENABLETEMPLATE | OFN_ENABLETEMPLATEHANDLE);
	else
		sFile.Flags = OFN_EXPLORER | OFN_NOCHANGEDIR;

	if (PCount() >= 6)
		sFile.FlagsEx = p6.ev_long;

	sFile.lStructSize = sizeof(OPENFILENAME);
	// set callback procedure 
	sFile.Flags |= OFN_ENABLEHOOK;
	sFile.lpfnHook = &GetFileNameCallback;

	sFile.hwndOwner = WTopHwnd();

	pFiles[0] = '\0';
	sFile.lpstrFile = pFiles;
	sFile.nMaxFile = MAX_OPENFILENAME_BUFFER;

	if (pFilter.Len())
		sFile.lpstrFilter = pFilter;
	else if (!(sFile.Flags & OFN_EXPLORER))
		sFile.lpstrFilter = "All\0*.*\0";

	if (pFileName.Len())
		strcpy(sFile.lpstrFile,pFileName);
	if (pInitialDir.Len())
		sFile.lpstrInitialDir = pInitialDir;
	if (pTitle.Len())
		sFile.lpstrTitle = pTitle;

	if (pCallback.Len())
	{
		sFile.lCustData = (LPARAM)&sCallbackParam;
		sCallbackParam.pCallback = pCallback;
		sCallbackParam.pCallback += "(%I,%U,%I)";
	}

	if (GetSaveFileName(&sFile)) {
		pFiles.StringLen();
		if (pFilter.Len() && sFile.nFilterIndex) {
			char *pSelectedFilter = pFilter;
			for (unsigned int xj = 1; xj < sFile.nFilterIndex * 2; xj++)
				pSelectedFilter += strlen(pSelectedFilter) + 1;

			FoxString pExtension = pSelectedFilter;
			pExtension.SubStr(pExtension.Rat('.'));
			if (!pExtension.ICompare(".*")) {
				if (pFiles.At('.')) {
					FoxString pCurrentExtension = pFiles;
					pCurrentExtension.SubStr(pCurrentExtension.Rat('.'));
					if (!pCurrentExtension.ICompare(pExtension))
						pFiles += pExtension;
				}
				else
					pFiles += pExtension;
			}
		}
		pFiles.Return();
	}
	else
	{
		DWORD nLastError = CommDlgExtendedError();
		if (nLastError)
		{
			SaveCustomError("GetSaveFileName", "Function failed: %I", nLastError);
			Return(-1);
		}
		else
			Return(0);
	}
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

UINT_PTR _stdcall GetFileNameCallback(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	LPOPENFILENAME lpOpfn;
	OpenfileCallback *lpCallback;
	NMHDR *lpHdr;

	if (uMsg == WM_INITDIALOG)
	{
		lpOpfn = reinterpret_cast<LPOPENFILENAME>(lParam);
		if (lpOpfn->lCustData)
			SetWindowLong(hDlg, GWL_USERDATA, static_cast<LONG>(lpOpfn->lCustData));
	}
	else if (uMsg == WM_NOTIFY)
	{
		lpCallback = reinterpret_cast<OpenfileCallback*>(GetWindowLong(hDlg,GWL_USERDATA));
		if (lpCallback)
		{
			lpHdr = reinterpret_cast<NMHDR*>(lParam);
			lpCallback->pBuffer.Format(lpCallback->pCallback, lpHdr->hwndFrom, lpHdr->idFrom, lpHdr->code);
			lpCallback->nErrorNo = _Evaluate(&lpCallback->vRetVal, lpCallback->pBuffer);
			if (!lpCallback->nErrorNo)
			{
				if (Vartype(lpCallback->vRetVal) == 'I')
					return lpCallback->vRetVal.ev_long;
				else if (Vartype(lpCallback->vRetVal) == 'N')
					return static_cast<UINT_PTR>(lpCallback->vRetVal.ev_real);
				else if (Vartype(lpCallback->vRetVal) == 'L')
					return lpCallback->vRetVal.ev_length;
				else
				{
					ReleaseValue(lpCallback->vRetVal);
					lpCallback->vRetVal.ev_type = '0';
				}
			}
		}
	}
	return FALSE;
}

void _fastcall ADriveInfo(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1);
	FoxString pDrive = "X:\\";
	ApiHandle hDriveHandle;
	
	STORAGE_DEVICE_NUMBER sDevNo;
	BOOL bApiRet;
	DWORD nDriveMask, nDriveCnt = 0, nMask = 1, dwBytes;	

	char pDriveEx[] = "\\\\.\\X:";

	nDriveMask = GetLogicalDrives();
	for (unsigned int xj = 0; xj <= 31; xj++)
	{
		if (nDriveMask & nMask)
			nDriveCnt++;
		nMask <<= 1;
	}

	pArray.Dimension(nDriveCnt,4);

	nMask = 1;
	unsigned int nRow = 0;
	for (unsigned int xj = 0; xj <= 31; xj++)
	{
		if (nDriveMask & nMask)
		{
			nRow++;

			pDrive[0] = (char)('A' + xj);
			pArray(nRow,1) = pDrive;
			pArray(nRow,2) = GetDriveType(pDrive);

			// replace X in "\\.\X:" with the drive letter
			pDriveEx[4] = pDrive[0];
			hDriveHandle = CreateFile(pDriveEx,0,0,0,OPEN_EXISTING,0,0);
			if (!hDriveHandle)
			{
				SaveWin32Error("CreateFile", GetLastError());
				throw E_APIERROR;
			}

			bApiRet = DeviceIoControl(hDriveHandle, IOCTL_STORAGE_GET_DEVICE_NUMBER, 0, 0, &sDevNo, sizeof(sDevNo), &dwBytes,0);
			if (bApiRet)
			{
				pArray(nRow,3) = sDevNo.DeviceNumber;
				pArray(nRow,4) = sDevNo.PartitionNumber;
			}
			else
			{
				pArray(nRow,3) = -1;
				pArray(nRow,4) = -1;
			}
		}
		nMask <<= 1;
	}

	pArray.ReturnRows();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AVolumes(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1, 1);
	VolumeSearch pSearch;

	if (pSearch.FindFirst())
	{
		pArray.Grow();
		pArray = pSearch.Volume();
	}
	else
	{
		Return(0);
		return;
	}

	while (pSearch.FindNext())
	{
		pArray.Grow();
		pArray = pSearch.Volume();
	}

	pArray.ReturnRows();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AVolumeMountPoints(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1, 1);
	FoxString pVolume(p2);
	VolumeMountPointSearch pSearch;

	if (pSearch.FindFirst(pVolume))
	{
		pArray.Grow();
		pArray = pSearch.MountPoint();
	}
	else
	{
		Return(0);
		return;
	}

	while (pSearch.FindNext())
	{
		pArray.Grow();
		pArray = pSearch.MountPoint();
	}

	pArray.ReturnRows();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AVolumePaths(ParamBlk *parm)
{
try
{
	if (!fpGetVolumePathNamesForVolumeName)
		throw E_NOENTRYPOINT;

	FoxArray pArray(p1);
	FoxString pVolume(p2);
	FoxString pBuffer(2048);
	DWORD dwLen; 

	do 
	{
		if (!fpGetVolumePathNamesForVolumeName(pVolume, pBuffer, pBuffer.Size(), &dwLen))
		{
			DWORD nLastError = GetLastError();
			if (nLastError == ERROR_MORE_DATA)
			{
				pBuffer.Size(dwLen);
			}
			else
			{
				SaveWin32Error("GetVolumePathNamesForVolumeName", GetLastError());
				throw E_APIERROR;
			}
		}
		else
			break;
	} while (true);

	unsigned int nCount = pBuffer.StringDblCount();
	if (nCount == 0)
	{
		Return(0);
		return;
	}

	FoxString pPath(512);
	unsigned int nRow = 0;
	char *pPathPtr = pBuffer;
	pArray.Dimension(nCount);
	while (nCount--)
	{
		nRow++;
		pArray(nRow) = pPath = pPathPtr;
		// advance pointer by length of string + 1 for nullterminator
		pPathPtr += pPath.Len() + 1;
	}	

	pArray.ReturnRows();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AVolumeInformation(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1, 5);
	FoxString pRootPath(p2, 2);
	FoxString pVolumeName(MAX_PATH+1);
	FoxString pFileSystemName(MAX_PATH+1);
	DWORD dwVolumeSerialNumber, dwMaximumComponentLen, dwFileSystemFlags;

	SwitchErrorMode pErrorMode(SEM_FAILCRITICALERRORS);

	pRootPath.AddBs();
	if (!GetVolumeInformation(pRootPath, pVolumeName, pVolumeName.Size(), &dwVolumeSerialNumber, &dwMaximumComponentLen, 
							&dwFileSystemFlags, pFileSystemName, pFileSystemName.Size()))
	{
		SaveWin32Error("GetVolumeInformation", GetLastError());
		throw E_APIERROR;
	}

	pArray(1) = pVolumeName.StringLen();
	pArray(2) = dwVolumeSerialNumber;
	pArray(3) = dwMaximumComponentLen;
	pArray(4) = dwFileSystemFlags;
	pArray(5) = pFileSystemName.StringLen();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetWindowsDirectoryLib(ParamBlk *parm)
{
try
{
	FoxString pDir(MAX_PATH+1);

	pDir.Len(GetWindowsDirectory(pDir,MAX_PATH+1));
	if (!pDir.Len())
	{
		SaveWin32Error("GetWindowsDirectory", GetLastError());
		throw E_APIERROR;
	}

	pDir.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall GetSystemDirectoryLib(ParamBlk *parm)
{
try
{
	FoxString pDir(MAX_PATH+1);

	pDir.Len(GetSystemDirectory(pDir,MAX_PATH+1));
    if (!pDir.Len())
	{
		SaveWin32Error("GetSystemDirectory", GetLastError());
		throw E_APIERROR;
	}

	pDir.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall ExpandEnvironmentStringsLib(ParamBlk *parm)
{
try
{
	FoxString pEnvString(p1);
	FoxString pEnvBuffer(MAX_ENVSTRING_BUFFER);

	pEnvBuffer.Len(ExpandEnvironmentStrings(pEnvString, pEnvBuffer, pEnvBuffer.Size()));
	if (!pEnvBuffer.Len())
	{
		SaveWin32Error("ExpandEnvironmentStrings", GetLastError());
		throw E_APIERROR;
	}
	else if (pEnvBuffer.Len() > MAX_ENVSTRING_BUFFER)
	{
		pEnvBuffer.Size(pEnvBuffer.Len());
		pEnvBuffer.Len(ExpandEnvironmentStrings(pEnvString,pEnvBuffer,pEnvBuffer.Size()));
		if (!pEnvBuffer.Len())
		{
			SaveWin32Error("ExpandEnvironmentStrings", GetLastError());
			throw E_APIERROR;
		}
	}
	pEnvBuffer.Len(pEnvBuffer.Len()-1); // subtract nullterminator
	pEnvBuffer.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _stdcall CreateDirectoryExEx(const char *pDirectory) throw(int)
{
	if (!FileExists(pDirectory))
	{
		if (!CreateDirectory(pDirectory,0))
		{
			SaveWin32Error("CreateDirectory", GetLastError());
			throw E_APIERROR;
		}
	}
}

void _stdcall RemoveDirectoryEx(const char *pPath) throw(int)
{
	BOOL bRetVal;
	bRetVal = RemoveDirectory(pPath);
	if (!bRetVal)
	{
		SaveWin32Error("RemoveDirectory", GetLastError());
		throw E_APIERROR;
	}
}

void _stdcall DeleteDirectoryEx(const char *pDirectory) throw(int)
{
	FileSearch pFileSearch;
	CStr pSearch(MAX_PATH);
	CStr pFile(MAX_PATH);
	CStr pPath(MAX_PATH);

	pSearch = pPath = pDirectory;
	pPath.AddBs();
	pSearch.AddBsWc();
	
	if (!pFileSearch.FindFirst(pSearch))
		return;

	do
	{
		if (pFileSearch.File.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
		{
			if (pFileSearch.IsFakeDir())
				continue;

			pFile = pPath;
			pFile += pFileSearch.Filename();
			DeleteDirectoryEx(pFile);
		}
		else
		{
			pFile = pPath;
			pFile += pFileSearch.Filename();
			DeleteFileExEx(pFile,pFileSearch.File.dwFileAttributes);
		}
	} while (pFileSearch.FindNext());

	RemoveDirectoryEx(pDirectory);
}

void _stdcall DeleteFileExEx(const char *pFileName, DWORD nFileAttribs) throw(int)
{
	RemoveReadOnlyAttrib(pFileName,nFileAttribs);
	if (!DeleteFile(pFileName))
	{
		SaveWin32Error("DeleteFile", GetLastError());
		throw E_APIERROR;
	}
}

void _stdcall DeleteFileExExW(const wchar_t *pFileName, DWORD nFileAttribs) throw(int)
{
	RemoveReadOnlyAttribW(pFileName, nFileAttribs);
	if (!DeleteFileW(pFileName))
	{
		SaveWin32Error("DeleteFile", GetLastError());
		throw E_APIERROR;
	}
}

void _stdcall RemoveReadOnlyAttrib(const char *pFileName, DWORD nFileAttribs) throw(int)
{
	if (nFileAttribs == INVALID_FILE_ATTRIBUTES)
	{
		nFileAttribs = GetFileAttributes(pFileName);
		if (nFileAttribs == INVALID_FILE_ATTRIBUTES)
		{
			SaveWin32Error("GetFileAttributes", GetLastError());
			throw E_APIERROR;
		}
	}
	if (nFileAttribs & FILE_ATTRIBUTE_READONLY)
	{
		if (!SetFileAttributes(pFileName,nFileAttribs & ~FILE_ATTRIBUTE_READONLY))
		{
			SaveWin32Error("SetFileAttributes", GetLastError());
			throw E_APIERROR;
		}
	}
}

void _stdcall RemoveReadOnlyAttribW(const wchar_t *pFileName, DWORD nFileAttribs) throw(int)
{
	if (nFileAttribs == INVALID_FILE_ATTRIBUTES)
	{
		nFileAttribs = GetFileAttributesW(pFileName);
		if (nFileAttribs == INVALID_FILE_ATTRIBUTES)
		{
			SaveWin32Error("GetFileAttributes", GetLastError());
			throw E_APIERROR;
		}
	}
	if (nFileAttribs & FILE_ATTRIBUTE_READONLY)
	{
		if (!SetFileAttributesW(pFileName,nFileAttribs & ~FILE_ATTRIBUTE_READONLY))
		{
			SaveWin32Error("SetFileAttributes", GetLastError());
			throw E_APIERROR;
		}
	}
}

bool _stdcall PathIsSameVolume(const char *pPath1, const char *pPath2) throw(int)
{
	char aMountPoint1[MAX_PATH];
	char aMountPoint2[MAX_PATH];
    /* Win2k und neuere OS's unterst�tzen MountPoints
    d.h. Man(n) kann beliebige Laufwerke auf beliebige Pfade mounten
    z.b. Laufwerk D: auf C:\DriveD\
    GetVolumePathName gibt den Mountpoint eines Pfades zur�ck */
	if (!GetVolumePathName(pPath1,aMountPoint1,MAX_PATH))
	{
		SaveWin32Error("GetVolumePathName", GetLastError());
		throw E_APIERROR;
	}
	if (!GetVolumePathName(pPath2,aMountPoint2,MAX_PATH))
	{
		SaveWin32Error("GetVolumePathName", GetLastError());
		throw E_APIERROR;
	}
	return strcmp(aMountPoint1,aMountPoint2) == 0;
}

bool _stdcall FileExists(const char *pFileName) throw(int)
{
	HANDLE hFile;
	DWORD nLastError;

	hFile = CreateFile(pFileName,0,0,0,OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS,0);
	if (hFile != INVALID_HANDLE_VALUE)
		CloseHandle(hFile);
	else
	{
		nLastError = GetLastError();
		if (nLastError == ERROR_FILE_NOT_FOUND || nLastError == ERROR_PATH_NOT_FOUND)
			return false;
	}
	return true;
}

int _stdcall CompareFileTimesEx(const char *pSourceFile, const char *pDestFile) throw(int)
{
	ApiHandle hSource, hDest;
	LARGE_INTEGER sSourceTime, sDestTime;

	hSource = CreateFile(pSourceFile,0,0,0,OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS,0);
	if (!hSource)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	hDest = CreateFile(pDestFile,0,0,0,OPEN_EXISTING,FILE_FLAG_BACKUP_SEMANTICS,0);
	if (!hDest)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}
	
	if (!GetFileTime(hSource,0,0,(LPFILETIME)&sSourceTime))
	{
		SaveWin32Error("GetFileTime", GetLastError());
		throw E_APIERROR;
	}

	if (!GetFileTime(hDest,0,0,(LPFILETIME)&sDestTime))
	{
		SaveWin32Error("GetFileTime", GetLastError());
		throw E_APIERROR;
	}

	if (sSourceTime.QuadPart == sDestTime.QuadPart)
		return 0;
	else if (sSourceTime.QuadPart > sDestTime.QuadPart)
		return 1;
	else
		return 2;
}

void _fastcall FCreateEx(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);

	HANDLE hFile;
	DWORD dwAccess, dwShare, dwFlags;

	MapFileAccessFlags(PCount() >= 2 ? p2.ev_long : FILE_ATTRIBUTE_NORMAL, PCount() >= 3 ? p3.ev_long : 2, PCount() >= 4 ? p4.ev_long : 0, &dwAccess, &dwShare, &dwFlags);

	if (pFileName.Len() <= MAX_PATH)
		hFile = CreateFile(pFileName, dwAccess, dwShare, 0, CREATE_ALWAYS, dwFlags, 0);
	else
	{
		if (pFileName[0] != '\\' || pFileName[1] != '\\' || pFileName[2] != '?' || pFileName[3] != '\\')
			pFileName.Prepend("\\\\?\\");
		FoxWString pFileNameW(pFileName);
		hFile = CreateFileW(pFileNameW,dwAccess,dwShare,0,CREATE_ALWAYS,dwFlags,0);
	}

	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	VFP2CTls::Tls().FileHandles.AddTail(hFile);
	Return(hFile);
}
catch(int nErrorNo)
{
	if (nErrorNo == E_APIERROR)
		Return(-1);
	else
		RaiseError(nErrorNo);
}
}

void _fastcall FOpenEx(ParamBlk *parm)
{
try
{
	FoxString pFileName(p1);
	HANDLE hFile;
	DWORD dwAccess, dwShare, dwFlags;

	// get a free entry in our file handle array
	pFileName.Fullpath();

	MapFileAccessFlags(PCount() >= 2 ? p2.ev_long : 0, PCount() >= 3 ? p3.ev_long : 2, PCount() >= 4 ? p4.ev_long : 0, &dwAccess, &dwShare, &dwFlags);

	if (pFileName.Len() <= MAX_PATH)
        hFile = CreateFile(pFileName,dwAccess,dwShare,0,OPEN_EXISTING,dwFlags,0);
	else
	{
		if (pFileName[0] != '\\' || pFileName[1] != '\\' || pFileName[2] != '?' || pFileName[3] != '\\')
			pFileName.Prepend("\\\\?\\");
		FoxWString pFileNameW(pFileName);
		hFile = CreateFileW(pFileNameW,dwAccess,dwShare,0,OPEN_EXISTING,dwFlags,0);
	}

	if (!hFile)
	{
		SaveWin32Error("CreateFile", GetLastError());
		throw E_APIERROR;
	}

	VFP2CTls::Tls().FileHandles.AddTail(hFile);
	Return(hFile);
}
catch(int nErrorNo)
{
	if (nErrorNo == E_APIERROR)
		Return(-1);
	else
		RaiseError(nErrorNo);
}
}

void _fastcall FCloseEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	VFP2CTls& tls = VFP2CTls::Tls();

	if (hFile != INVALID_HANDLE_VALUE)
	{
		bApiRet = CloseHandle(hFile);
		if (!bApiRet)
			SaveWin32Error("CloseHandle", GetLastError());
		else
		{
			POSITION pos = tls.FileHandles.Find(hFile);
			if (pos)
				tls.FileHandles.RemoveAt(pos);
		}
	}
	else
	{
		bApiRet = TRUE;
		while (!tls.FileHandles.IsEmpty())
			CloseHandle(tls.FileHandles.RemoveTail());
	}

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FReadEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	DWORD dwRead;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	FoxString pData(p2.ev_long);

	bApiRet = ReadFile(hFile, pData, pData.Size(), &dwRead, 0);
	if (!bApiRet)
		SaveWin32Error("ReadFile", GetLastError());

	pData.Len(bApiRet ? dwRead : 0); 
	pData.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FWriteEx(ParamBlk *parm)
{
try
{
	if (PCount() == 3 && p3.ev_long < 0)
		throw E_INVALIDPARAMS;

	BOOL bApiRet;
	DWORD dwWritten, dwLength;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	FoxString pData(p2,0);

	if (PCount() == 3 && pData.Len() >= static_cast<DWORD>(p3.ev_long))
		dwLength = p3.ev_long;
	else
		dwLength = pData.Len();

	bApiRet = WriteFile(hFile, pData, dwLength, &dwWritten,0);
	if (!bApiRet)
		SaveWin32Error("WriteFile",GetLastError());

	if (bApiRet)
		Return(dwWritten);
	else
		Return(0);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FGetsEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	unsigned char *pData, *pOrigData;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	int dwLen = PCount() == 2 ? p2.ev_long : 256;
	int bCarri = 0;
	LONG dwRead, dwBuffer;
	LARGE_INTEGER distance;
	FoxString pBuffer(dwLen);

	pOrigData = pData = pBuffer;

	dwBuffer = min(dwLen,VFP2C_FILE_LINE_BUFFER);
	while(true)
	{
		bApiRet = ReadFile(hFile, pData, dwBuffer, reinterpret_cast<LPDWORD>(&dwRead), 0);
		if (!bApiRet)
		{
			SaveWin32Error("ReadFile", GetLastError());
			throw E_APIERROR;
		}

		if (dwRead == 0)
			break;

		while (dwRead--)
		{
			if (*pData == '\r') // carriage return detected
			{
				pData++;
				if (*pData == '\n') // skip over linefeeds
				{
					bCarri = 2;
					pData++;
					dwRead--;
				}
				else
					bCarri = 1; // set detect flag

				distance.QuadPart = -dwRead;
				SetFilePointerEx(hFile, distance, 0, FILE_CURRENT); // position filepointer after carriage return and optional linefeed
				break;
			}
			else if (*pData == '\n')
			{
				pData++;
				distance.QuadPart = -dwRead;
				SetFilePointerEx(hFile, distance, 0, FILE_CURRENT); // position filepointer after linefeed
				bCarri = 1; // set detect flag
				break;
			}
			else
				pData++;
		}

		if (bCarri || (pData - pOrigData >= dwLen))
			break;
	}

	pBuffer.Len(pData - pOrigData - bCarri);
	pBuffer.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FPutsEx(ParamBlk *parm)
{
try
{
	if (PCount() == 3 && p3.ev_long < 0)
		throw E_INVALIDPARAMS;

	BOOL bApiRet;
	DWORD dwWritten, dwLength;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	FoxString pData(p2,2);

	if (PCount() == 3 && pData.Len() >= static_cast<DWORD>(p3.ev_long))
		dwLength = p3.ev_long;
	else
		dwLength = pData.Len();

	// add carriage return & line feed to data
	pData[dwLength] = '\r';
	pData[dwLength+1] = '\n';

	bApiRet = WriteFile(hFile, pData, dwLength + 2, &dwWritten,0);
	if (!bApiRet)
		SaveWin32Error("WriteFile", GetLastError());

	if (bApiRet)
		Return(dwWritten);
	else
		Return(0);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FSeekEx(ParamBlk *parm)
{
try
{
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	LARGE_INTEGER nFilePos;
	FoxInt64 pNewFilePos;
	DWORD dwMove = PCount() == 3 ? p3.ev_long : FILE_BEGIN;

	nFilePos.QuadPart = static_cast<__int64>(p2.ev_real);
	nFilePos.LowPart = SetFilePointer(hFile, nFilePos.LowPart, &nFilePos.HighPart, dwMove);
	if (nFilePos.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR)
	{
		SaveWin32Error("SetFilePointer", GetLastError());
		throw E_APIERROR;
	}

	pNewFilePos = nFilePos.QuadPart;
	pNewFilePos.Return();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FEoFEx(ParamBlk *parm)
{
try
{
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	LARGE_INTEGER nCurr, nEof;
	DWORD dwLastError, nReset;

	nCurr.HighPart = 0;
	nCurr.LowPart = SetFilePointer(hFile, 0, &nCurr.HighPart, FILE_CURRENT);
	if (nCurr.LowPart == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	nEof.HighPart = 0;
	nEof.LowPart = SetFilePointer(hFile,0,&nEof.HighPart,FILE_END);
	if (nEof.LowPart == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	nReset = SetFilePointer(hFile,nCurr.LowPart,&nCurr.HighPart,FILE_BEGIN);
	if (nReset == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	Return(nCurr.QuadPart == nEof.QuadPart);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FChSizeEx(ParamBlk *parm)
{
try
{
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	BOOL bApiRet;
	LARGE_INTEGER nSize;
	LARGE_INTEGER nCurrPos;
	DWORD dwRet, dwLastError;
	FoxInt64 pFilePos;

	nSize.QuadPart = static_cast<__int64>(p2.ev_real);
    
	// save current file pointer
	nCurrPos.HighPart = 0;
	nCurrPos.LowPart = SetFilePointer(hFile, 0, &nCurrPos.HighPart, FILE_CURRENT);
	if (nCurrPos.LowPart == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	// set file pointer to specified size
	nSize.LowPart = SetFilePointer(hFile, nSize.LowPart, &nSize.HighPart, FILE_BEGIN);
	if (nSize.LowPart == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	// set file size
	bApiRet = SetEndOfFile(hFile);
	if (!bApiRet)
	{
		SaveWin32Error("SetEndOfFile", GetLastError());
		throw E_APIERROR;
	}

	// reset file pointer to saved position
	dwRet = SetFilePointer(hFile, nCurrPos.LowPart, &nCurrPos.HighPart, FILE_BEGIN);
	if (dwRet == INVALID_SET_FILE_POINTER)
	{
		dwLastError = GetLastError();
		if (dwLastError != NO_ERROR)
		{
			SaveWin32Error("SetFilePointer", dwLastError);
			throw E_APIERROR;
		}
	}

	pFilePos = nSize.QuadPart;
	pFilePos.Return();
}
catch(int nErrorNo)
{
	if (nErrorNo == E_APIERROR)
		Return(0);
	else
		RaiseError(nErrorNo);
}
}

void _fastcall FFlushEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	bApiRet = FlushFileBuffers(hFile);
	if (!bApiRet)
		SaveWin32Error("FlushFileBuffers", GetLastError());

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FLockFile(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	LARGE_INTEGER nOffset, nLen;

	if (Vartype(p2) == 'I')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_long);
	else if (Vartype(p2) == 'N')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_real);
	else
		throw E_INVALIDPARAMS;

	if (Vartype(p3) == 'I')
		nLen.QuadPart = static_cast<__int64>(p3.ev_long);
	else if (Vartype(p3) == 'N')
		nLen.QuadPart = static_cast<__int64>(p3.ev_real);
	else
		throw E_INVALIDPARAMS;

	bApiRet = LockFile(hFile, nOffset.LowPart, nOffset.HighPart, nLen.LowPart, nLen.HighPart);
	if (!bApiRet)
		SaveWin32Error("LockFile", GetLastError());

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FUnlockFile(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	LARGE_INTEGER nOffset, nLen;

	if (Vartype(p2) == 'I')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_long);
	else if (Vartype(p2) == 'N')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_real);
	else
		throw E_INVALIDPARAMS;

	if (Vartype(p3) == 'I')
		nLen.QuadPart = static_cast<__int64>(p3.ev_long);
	else if (Vartype(p3) == 'N')
		nLen.QuadPart = static_cast<__int64>(p3.ev_real);
	else
		throw E_INVALIDPARAMS;

	bApiRet = UnlockFile(hFile, nOffset.LowPart, nOffset.HighPart, nLen.LowPart, nLen.HighPart);
	if (!bApiRet)
		SaveWin32Error("UnlockFile", GetLastError());

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FLockFileEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	DWORD dwFlags = PCount() == 4 ? p4.ev_long : 0;
	LARGE_INTEGER nOffset, nLen;
	OVERLAPPED sOverlap;

	if (Vartype(p2) == 'I')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_long);
	else if (Vartype(p2) == 'N')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_real);
	else
		throw E_INVALIDPARAMS;

	if (Vartype(p3) == 'I')
		nLen.QuadPart = static_cast<__int64>(p3.ev_long);
	else if (Vartype(p3) == 'N')
		nLen.QuadPart = static_cast<__int64>(p3.ev_real);
	else
		throw E_INVALIDPARAMS;

	sOverlap.hEvent = 0;
	sOverlap.Offset = nOffset.LowPart;
	sOverlap.OffsetHigh = nOffset.HighPart;

	bApiRet = LockFileEx(hFile, dwFlags, 0, nLen.LowPart, nLen.HighPart, &sOverlap);

	if (!bApiRet)
		SaveWin32Error("LockFileEx", GetLastError());

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall FUnlockFileEx(ParamBlk *parm)
{
try
{
	BOOL bApiRet;
	HANDLE hFile = reinterpret_cast<HANDLE>(p1.ev_long);
	LARGE_INTEGER nOffset, nLen;
	OVERLAPPED sOverlap;

	if (Vartype(p2) == 'I')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_long);
	else if (Vartype(p2) == 'N')
		nOffset.QuadPart = static_cast<__int64>(p2.ev_real);
	else
		throw E_INVALIDPARAMS;

	if (Vartype(p3) == 'I')
		nLen.QuadPart = static_cast<__int64>(p3.ev_long);
	else if (Vartype(p3) == 'N')
		nLen.QuadPart = static_cast<__int64>(p3.ev_real);
	else
		throw E_INVALIDPARAMS;

	sOverlap.hEvent = 0;
	sOverlap.Offset = nOffset.LowPart;
	sOverlap.OffsetHigh = nOffset.HighPart;

	bApiRet = UnlockFileEx(hFile, 0, nLen.LowPart, nLen.HighPart, &sOverlap);
	if (!bApiRet)
		SaveWin32Error("UnlockFileEx", GetLastError());

	Return(bApiRet == TRUE);
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _fastcall AFHandlesEx(ParamBlk *parm)
{
try
{
	FoxArray pArray(p1);	
	VFP2CTls& tls = VFP2CTls::Tls();
	size_t nHandleCnt = tls.FileHandles.GetCount();

	if (nHandleCnt == 0)
	{
		Return(0);
		return;
	}

	pArray.Dimension(nHandleCnt, 1);

	size_t xj = 1;
	POSITION pos = tls.FileHandles.GetHeadPosition();
	while(pos)
	{
		pArray(xj) = tls.FileHandles.GetNext(pos);;
		xj++;
	}

	pArray.ReturnRows();
}
catch(int nErrorNo)
{
	RaiseError(nErrorNo);
}
}

void _stdcall MapFileAccessFlags(int nFileAttribs, int nAccess, int nShare, LPDWORD pAccess, LPDWORD pShare, LPDWORD pFlags) throw(int)
{
	*pAccess = 0;
	*pShare = 0;
	*pFlags = 0;

	switch (nAccess)
	{
		case 0:
			*pAccess = GENERIC_READ;
			break;
		case 1:
			*pAccess = GENERIC_WRITE;
			break;
		case 2:
			*pAccess = GENERIC_READ | GENERIC_WRITE;
			break;
		default:
			throw E_INVALIDPARAMS;
	}

	if (nFileAttribs & ~(FILE_ATTRIBUTE_ARCHIVE | FILE_ATTRIBUTE_ENCRYPTED | 
						FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_NORMAL |
						FILE_ATTRIBUTE_NOT_CONTENT_INDEXED | FILE_ATTRIBUTE_OFFLINE |
						FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_SYSTEM |
						FILE_ATTRIBUTE_TEMPORARY | FILE_FLAG_BACKUP_SEMANTICS |
						FILE_FLAG_DELETE_ON_CLOSE | FILE_FLAG_OPEN_NO_RECALL |
						FILE_FLAG_OPEN_REPARSE_POINT | FILE_FLAG_POSIX_SEMANTICS |
						FILE_FLAG_RANDOM_ACCESS | FILE_FLAG_SEQUENTIAL_SCAN |
						FILE_FLAG_WRITE_THROUGH))
		throw E_INVALIDPARAMS;

	*pFlags |= nFileAttribs;

	if (nShare & ~(FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_SHARE_DELETE))
		throw E_INVALIDPARAMS;

	*pShare = nShare;
}