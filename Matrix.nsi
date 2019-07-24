;安装脚本
;设置压缩方式，采用压缩效果最好的压缩方式
SetCompressor /SOLID lzma
LoadLanguageFile "SimpleChinese.nlf"

;定义全局字符串
!define PRODUCT_NAME "YoYo"; 产品名称
!define PRODUCT_CAPTION "YoYo经费系统产品"; 安装程序标题
!define PRODUCT_VERSION "V1.0.0";版本号
!define PRODUCT_PUBLISHER "刘兴俊"; 程序作者
!define PRODUCT_ICON "setup.ico";安装程序图标
!define PRODUCT_UNINSTALL_ICON "uninstall.ico"; 卸载程序图标
!define PROCUCT_INSTALL_NAME "系统安装程序V1.0.0"; 安装程序版本
!define SOURCET_FOLDER "eclipse\*.*";安装程序源文件所在的文件夹

;安装配置细节
Name "${PRODUCT_CAPTION}${PRODUCT_VERSION}"
Caption "${PRODUCT_CAPTION}"
Icon "${PRODUCT_ICON}"
UninstallIcon "${PRODUCT_UNINSTALL_ICON}"
BGGradient 8cb3e1 000000 0000ff; 渐变式背景
InstProgressFlags smooth colored; 平滑式安装进度条
BrandingText /TRIMCENTER "${PROCUCT_INSTALL_NAME}"
CompletedText "安装已经完成！"安装完成后的提示信息
AutoCloseWindow false;不自动关闭安装窗口
ShowInstDetails show;显示安装细节
ShowUninstDetails show; 显示卸载文件细节

OutFile setup.exe
InstallDir "$PROGRAMFILES/YoYo";默认安装目录Program\YoYo

LicenseData "YoYo.rtf"; 许可证数据文件
LicenseForceSelection radiobuttons "我接受“许可证协议”中的条款 " "我不接受“许可证协议”中的条款"

Page license;许可协议页
PageEx directory;选择安装目录页
  DirVerify leave; 检测安装目录磁盘空间的有效性
PageExEnd

Page instfiles; 安装文件细节页
UninstPage uninstConfirm; 卸载确认页
UninstPage instfiles; 卸载文件细节页
;安装区段
Section "Install"
  SetOutPath $INSTDIR
  File /r "${SOURCET_FOLDER}";将Eclipse导出产品文件夹Eclipse下的所有文件和文件夹打包进setup.ext
  WriteRegStr HKLM SOFTWARE\Microsoft\Windows\CurrentVersion\Run "${PRODUCT_NAME}" "$INSTDIR\YoYo.exe system"
  CreateShortCut "$DESKTOP\${PRODUCT_CAPTION}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
  CreateDirectory "$SMPROGRAMS\${PRODUCT_CAPTION}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_CAPTION}\${PRODUCT_CAPTION}.lnk"
      "$INSTDIR\${PRODUCT_NAME}.exe"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_CAPTION}\卸载${PRODUCT_CAPTION}.lnk"
      "$INSTDIR\${PRODUCT_NAME}-uninst.exe"
SectionEnd
;卸载区段
Section "Uninstall"
  DeleteRegValue HKLM"SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "${PRODUCT_NAME}"
  RMDir /r $SMPROGRAMS\${PRODUCT_CAPTION}
  RMDir /r $REBOOTOK $INSTDIR
  Delete "$DESKTOP\${PRODUCT_CAPTION}.lnk"
SectionEnd
;回调函数，使用了一个淡入淡出的画面，显示时间是3s
Function .onInit
  File /oname=$TEMP\splash.bmp "splash.bmp"
  advsplash::show 3000 600 400 -l $TEMP/splash
  Pop $0
  Delete $TEMP\splash.bmp
FunctionEnd
Function un.onInit
  MessageBox MB_YESNO "即将卸载${PRODUCT_CAPTION},要继续码？" IDYES go2
  Abort
  go2:
FunctionEnd
