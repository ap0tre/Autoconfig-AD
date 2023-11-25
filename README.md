    <h1>Active Directory Installation Script</h1>

    <p>This PowerShell script automates the configuration of network settings and the installation of Active Directory on a Windows Server.</p>

    <h2>Prerequisites</h2>

    <ul>
        <li>Windows Server environment</li>
        <li>PowerShell v5.1 or later</li>
    </ul>

    <h2>Usage</h2>

    <ol>
        <li>Open PowerShell as an administrator.</li>
        <li>Run the script:</li>
    </ol>

    <pre><code>.\ActiveDirectoryInstallation.ps1</code></pre>

    <ol start="3">
        <li>Follow the on-screen prompts to configure network settings and Active Directory.</li>
    </ol>

    <h2>Script Overview</h2>

    <ul>
        <li>Configures network settings using <code>New-NetIPAddress</code>.</li>
        <li>Installs required Windows features using <code>Add-WindowsFeature</code>.</li>
        <li>Configures Active Directory using <code>Install-ADDSForest</code>.</li>
        <li>Restarts the computer after configuration.</li>
    </ul>

    <h2>Important Notes</h2>

    <ul>
        <li>Ensure that you run the script with administrative privileges.</li>
        <li>Review the prompts carefully and provide accurate information.</li>
        <li>The script may require a system restart after completion.</li>
    </ul>
