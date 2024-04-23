import { startApp } from '../utils';

export const startInstalledApp = async (): ReturnType<typeof startApp> => {
  return startApp({ executablePath: getAppInstallPath() });
}

function getAppInstallPath(): string {
  switch (process.platform) {
    case 'win32':
      return 'C:\\Program Files\\Rostam VPN\\Rostam VPN.exe';
    case 'linux':
      return '/opt/Rostam VPN/mullvad-gui';
    case 'darwin':
      return '/Applications/Rostam VPN.app/Contents/MacOS/Rostam VPN';
    default:
      throw new Error('Platform not supported');
  }
}
