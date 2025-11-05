Import-Module PSReadLine
Import-Module PSFzf
Import-Module posh-git
Get-ChildItem "C:\Users\nidzo\.config\dotfiles\PowerShell\custom" | Import-Module

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

$env:FZF_DEFAULT_COMMAND = 'fd -tf --exclude obj --exclude node_modules'
$env:FZF_CTRL_T_COMMAND = 'fd --exclude obj --exclude node_modules'
$env:FZF_CTRL_T_OPTS = "--preview='bat --color=always  {}'"
$env:FZF_ALT_C_COMMAND = 'fd --type d . --exclude "Visual Studio 2022" --exclude "Virtual Machines"'
$env:FZF_DEFAULT_OPTS = "--extended --multi --inline-info --cycle --layout=reverse --min-height 80 --bind='f2:toggle-preview'"

Set-Alias -Name "ll" -Value "Get-ChildItem"
Invoke-Expression (&starship init powershell)

function dotfiles {
    code "$HOME\.config\dotfiles"
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# $env:COMPLETE = "powershell"
# dev | Out-String | Invoke-Expression
# Remove-Item Env:\COMPLETE
