## Contributing

**Contribution Guidelines**

- An issue should be opened prior to any work being done. State that you will be contributing in the issue, and what you intend to change.
- Create a fork or branch off the master branch.
- Modify, fix, or add code that pertains to the issue only.
- When creating a pull request reference the issue number.
- Code will be reviewed and committed to the master branch, or comments will be added to the issue if problems are found.

**Coding Guidelines**

- If you add a function, update the `Get-<ModuleName>` public function to include that new function. In the comments for that function follow the format for existing functions.
- All code should be written verbosely! Do not use Aliases or shortcuts.

**Documentation Guidelines**

- If a commit upgrades the version on a module, it should be in the commit comment.
- All added functions should contain comment above the function, with a single space so get-help can reference the comment block.
- If modifying an existing function, also update the comment help to reflect changes.
- Use PlatyPS module to create or update markdown help files. Example Below:

```Powershell
Install-Module PlatyPS -Force
$ModuleName = '<ModuleNameHere>'
$path = "./docs/<ModuleName>"
New-MarkdownHelp -Module $ModuleName -OutputFolder $path -force
```